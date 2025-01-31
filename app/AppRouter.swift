//
//  AppRouter.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 31/01/2025.
//

import UIKit
import BackbaseDesignSystem

/// `UIWindow` builder
typealias AppWindowUpdater = (UIWindow) -> Void

/// `UIViewController` builder using a `UINavigationController`.
typealias AppScreenBuilder = (UINavigationController) -> UIViewController

open class AppRouter {
    private var navigationController: UINavigationController = NavigationController()
    
    /// Create a new router instance
    required public init() { }
    
    func didStartApp(window: UIWindow) {
        // TODO: Do we need Splash screen?
        window.rootViewController = navigationController
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
