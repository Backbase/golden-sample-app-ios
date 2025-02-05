//
//  AppRouter.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 31/01/2025.
//

import UIKit
import BackbaseDesignSystem
import Backbase
import IdentityAuthenticationJourney
import Resolver
import BusinessWorkspacesJourney
import BackbaseAnimation

/// `UIWindow` builder
typealias AppWindowUpdater = (UIWindow) -> Void

/// `UIViewController` builder using a `UINavigationController`.
typealias AppScreenBuilder = (UINavigationController) -> UIViewController

open class AppRouter {
    private var navigationController: UINavigationController = NavigationController()
    
    internal var userInactivityTracker = UserInactivityTracker()
    
    /// Create a new router instance
    required public init() { }
    
    public var shouldAutoLogin: Bool {
        true
    }
    
    func didStartApp(window: UIWindow) {
        let viewController = Splash.build(navigationController: navigationController)
        navigationController.setViewControllers([viewController], animated: false)
        window.rootViewController = navigationController
    }
    
    open func didFinishLogin() {
        fatalError("Function should be overriden to configure journeys")
    }
    
    public func transitionToApp() {
        let animationSource: AnimationSource = .bundle { _ in
            return .init(resourceName: "transition_animation.json", in: .main)
        }
        
        var configuration = AnimationTransition.Configuration()
        
        configuration.router.didFinishTransition = { [weak self] _ in {
            self?.didFinishLogin()
            }
        }
        
        configuration.animation.source = animationSource
        
        let animationViewController = AnimationTransition.build(
            navigationController: navigationController,
            configuration: configuration
        )
        navigationController.setViewControllers([animationViewController], animated: false)
    }
    
    public func dismissViewController(animated: Bool = true) {
        navigationController.dismiss(animated: animated)
    }
    
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
                    self.set(builder: Login.build(shouldAutoLogin: self.shouldAutoLogin))
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
        let animationCompleter = TransitionCompleter(onComplete: completion)
        transition.duration = 0.3
        transition.type = .fade
        transition.delegate = animationCompleter
        navigationController.view.layer.add(transition, forKey: "kCATransition")
    }
    
    static func navigationController(startingWith screenBuilder: AppScreenBuilder, navigationController: UINavigationController) -> UINavigationController {
        let viewController = screenBuilder(navigationController)
        navigationController.viewControllers = [viewController]
        navigationController.tabBarItem = viewController.tabBarItem
        return navigationController
    }
}

private class TransitionCompleter: NSObject, CAAnimationDelegate {
    private var onComplete: (() -> Void)?
    
    init(onComplete: (() -> Void)?) {
        self.onComplete = onComplete
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        onComplete?()
    }
}
