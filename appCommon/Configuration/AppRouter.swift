//
//  AppRouter.swift
//  GoldenSampleApp
//
//  Created by Backbase on 31/01/2025.
//

import UIKit
import BackbaseDesignSystem
import Backbase
import IdentityAuthenticationJourney
import Resolver
import BusinessWorkspacesJourney


/**
 * A typealias for a function that builds a UIViewController for a specific app screen.
 *
 * `AppScreenBuilder` defines a type for functions that take a
 * `UINavigationController` as input and return a `UIViewController`.  This is
 * commonly used in navigation systems to create and configure view
 * controllers on demand.
 * The navigation controller is typically provided to allow the
 * created view controller to perform navigation actions.
 */
typealias AppScreenBuilder = (UINavigationController) -> UIViewController

/**
 * An open class responsible for navigating between screens in the application.
 *
 * `AppRouter` manages the navigation flow of the application. It holds an internal
 *  mechanism which it uses to push and present view controllers.  It also contains a
 *  mechanism to monitor and respond to user inactivity.
 */
open class AppRouter {
    private var navigationController: UINavigationController = NavigationController()
    
    internal var userInactivityTracker = UserInactivityTracker()
    
    /// Create a new `AppRouter` instance
    required public init() { }
  
    ///
    /// Called when the application has finished launching.
    ///
    /// This method sets up the initial view controller and performs initial app
    /// setup, including session validation.
    ///
    /// - Parameter window: The `UIWindow` object associated with the application.
    ///
    func didStartApp(window: UIWindow) {
        window.rootViewController = navigationController
        let authenticationUseCase = Resolver.resolve(AuthenticationUseCase.self)
        authenticationUseCase.validateSession(callback: nil)
    }
    
    ///
    /// Called when the user has successfully finished the login process.
    ///
    /// This method is called after a successful login. It's responsible for
    /// updating the navigation stack, typically by replacing the login flow with
    /// the main application content.  It receives the navigation controller used
    /// during the login process, which might be different from the main
    /// `navigationController` held by the `AppRouter`. This allows for a clean
    /// transition and potentially different navigation configurations post-login.
    ///
    /// - Parameter navigationController: The navigation controller used during the login flow.
    ///
    open func didFinishLogin(navigationController: UINavigationController) {
        fatalError("Function should be overriden to configure journeys")
    }
    
    ///
    /// Transitions the user to the main application interface.
    ///
    /// This method is responsible for navigating the user from the initial setup
    /// or authentication flows to the core content of the application.  It typically
    /// involves setting the root view controller of the main window or performing
    /// a navigation stack reset/replacement to display the primary user interface.
    ///
    public func transitionToApp() {
        didFinishLogin(navigationController: self.navigationController)
    }
    
    public func dismissViewController(animated: Bool = true) {
        navigationController.dismiss(animated: animated)
    }
    
    ///
    /// Sets the root view controller of the navigation controller.
    ///
    /// This method replaces the entire view controller stack of the navigation
    /// controller with the provided view controller.  It performs this operation
    /// on the main thread to ensure proper UI updates.  It optionally applies a
    /// fade-in animation to the navigation controller during the transition.
    ///
    /// - Parameters:
    /// - viewController: The new root view controller to set.
    /// - animated: A boolean value indicating whether to animate the transition.
        /// Defaults to `true`.
    /// - completion: An optional closure to be executed after the transition is complete.
    ///
    public func set(viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            if animated {
                self.addFadeAnimation(self.navigationController, completion: completion)
            }
            self.navigationController.setViewControllers([viewController], animated: false)
        }
    }
    
    func set(builder: @escaping AppScreenBuilder, animated: Bool = true, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            if animated {
                self.addFadeAnimation(self.navigationController, completion: completion)
            }
            self.navigationController.setViewControllers([builder(self.navigationController)], animated: false)
        }
    }
    
    ///
    /// Handles a change in the user's session.
    ///
    /// This method is called when the user's session is updated, such as after a
    /// successful login, logout, or session refresh.  It receives the new session
    /// object, which can be used to update the application's state and UI
    /// accordingly.
    ///
    /// - Parameter session: The new `Session` object representing the user's
    /// updated session.
    ///
    open func handleSessionChange(newSession session: Session) {
        DispatchQueue.main.async {
            switch session {
            case .valid:
                Workspaces.Configuration.appDefault.register()
                self.dismissViewController(animated: false)
                Workspaces.Configuration.workspaceChecker.handleWorkspaceSelection()
            case .none:
                let authenticationUseCase: AuthenticationUseCase = Resolver.resolve()
                if authenticationUseCase.isEnrolled {
                    self.set(builder: Login.build(shouldAutoLogin: true))
                } else {
                    self.set(builder: Register.build())
                }
            case .locked:
                self.set(builder: Register.build(session: .locked))
            case .expired:
                self.dismissViewController()
                self.set(builder: Login.build(session: .expired))
            @unknown default:
                fatalError()
            }
            
            if session != .valid {
                // Reset Resolver cache so we can create new configurations for the updated context
                Resolver.cached.reset()
                // Workaround: Re-register authentication to refresh theme colors dynamically
                // Note: Convert authentication variable to a computed property for automatic updates
                Resolver.register { Authentication.Configuration.appDefault }

                self.userInactivityTracker.stopInactivityTimer()
            }
        }
    }
}

private extension AppRouter {
    func addFadeAnimation(_ navigationController: UINavigationController, completion: (() -> Void)? = nil) {
        let transition = CATransition()
        let transitionDelegate = TransitionDelegate(onComplete: completion)
        transition.duration = 0.3
        transition.type = .fade
        transition.delegate = transitionDelegate
        navigationController.view.layer.add(transition, forKey: "kCATransition")
    }
    
    static func navigationController(startingWith screenBuilder: AppScreenBuilder, navigationController: UINavigationController) -> UINavigationController {
        let viewController = screenBuilder(navigationController)
        navigationController.viewControllers = [viewController]
        navigationController.tabBarItem = viewController.tabBarItem
        return navigationController
    }
}

private class TransitionDelegate: NSObject, CAAnimationDelegate {
    private var onComplete: (() -> Void)?
    
    init(onComplete: (() -> Void)?) {
        self.onComplete = onComplete
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        onComplete?()
    }
}
