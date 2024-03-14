//
//  Created by Backbase R&D B.V. on 13/03/2024
//

import Foundation
import UIKit
import BackbaseDesignSystem
import IdentityAuthenticationJourney
import BusinessWorkspacesJourney
import BusinessJourneyCommon
import Resolver

/// `UIWindow` builder.
typealias AppWindowUpdater = (UIWindow) -> Void

/// `UIViewController` builder using a `UINavigationController`.
typealias AppScreenBuilder = (UINavigationController) -> UIViewController

/// An enum representing a screen that can be used as an entry point for an app state (`AppState`).
enum EntryPoint {
    /// Single screen
    case single(AppScreenBuilder)
    /// Multiple screens grouped in a tabbed menu.
    case tabbedMenu([AppScreenBuilder])
}

final class AppRouter: AppDependency {
    /// Create a new router instance.
    init() {}

    /// Called when the app starts.
    var didStartApp: AppWindowUpdater = { window in
        window.rootViewController = UIViewController()
    }

    /// Called to update the app for a given state.
    var didUpdateState: ((AppState) -> AppWindowUpdater) = { state in
        { window in
            let builder: AppScreenBuilder
            switch state {
            case .notLoggedInNotEnrolled:
                builder = screenBuilder(for: .single(Register.build()))
            case .notLoggedInEnrolled:
                builder = screenBuilder(for: .single(Login.build(shouldAutoLogin: true)))
            case .loggedInEnrolled:
                builder = screenBuilder(for: .single(Workspaces.buildSelector))
            case .workspaceSelected:
                let userRepository = Resolver.resolve(UserRepository.self)
                builder = screenBuilder(for: .tabbedMenu([
                    DashboardHelper.build(serviceAgreementName: userRepository.user.serviceAgreementName ?? ""),
                    ComingSoonViewController.build(title: "Coming soon..")
                ]))
            case .sessionExpired:
                builder = screenBuilder(for: .single(Register.build(session: .locked)))
            case .accountLocked:
                builder = screenBuilder(for: .single(Login.build(session: .expired)))
            }
            let viewController = viewController(for: builder)
            window.rootViewController = viewController
        }
    }

    /// Returns a `UIViewController` for a given screen builder.
    /// Implement this method to provide a custom `UINavigationController` to be used when creating screens.
    /// - Parameter screenBuilder: screen builder.
    static func viewController(for screenBuilder: AppScreenBuilder) -> UIViewController {
        return screenBuilder(NavigationController())
    }

    /// Returns a screen builder for a given entry point.
    /// Implement this method to return a custom screen building block.
    /// - Parameter entryPoint: Entry point.
    static func screenBuilder(for entryPoint: EntryPoint) -> AppScreenBuilder {
        return { navigationController in
            switch entryPoint {
            case .single(let screen):
                return AppRouter.navigationController(startingWith: screen)
            case .tabbedMenu(let screens):
                let tabBarController = TabBarController()
                DesignSystem.shared.styles.tabBar(tabBarController.tabBar)
                tabBarController.viewControllers = screens.map(navigationController(startingWith:))
                return tabBarController
            }
        }
    }

    /// Returns a `UINavigationController` wrapping the given screen builder.
    /// Implement this method to change how the app wraps a `UIViewController` in a `UINavigationController`.
    /// - Parameter screenBuilder: Screen builder.
    static func navigationController(startingWith screenBuilder: AppScreenBuilder) -> UINavigationController {
        let navigationController: UINavigationController = NavigationController()
        let viewController = screenBuilder(navigationController)
        navigationController.viewControllers = [viewController]
        navigationController.tabBarItem = viewController.tabBarItem
        return navigationController
    }
}
