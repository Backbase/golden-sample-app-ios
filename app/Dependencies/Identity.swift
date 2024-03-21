//
//  AppDelegate+Identity.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 13/10/2023.
//

import UIKit
import Resolver
import Backbase
import IdentityAuthenticationJourney
import BusinessWorkspacesJourney
import BusinessWorkspacesJourneyWorkspacesUseCase2
import BusinessJourneyCommon
import RetailFeatureFilterUseCase
import RetailFeatureFilterAccessControlEntitlementsUseCase
import AccessControlClient3Gen2

extension Authentication.Configuration: AppDependency {
    func register() {
        let authenticationUseCase = IdentityAuthenticationUseCase(sessionChangeHandler: handleSessionChange(newSession:))
        Backbase.register(authClient: authenticationUseCase)

        Resolver.register { authenticationUseCase as AuthenticationUseCase }

        var authenticationConfiguration = Authentication.Configuration()
        authenticationConfiguration.login.autoLoginEnabled = true

        guard let window = UIApplication.shared.keyWindow else { fatalError("Failed to get window") }
        let navCoordinator = Authentication.NavigationCoordinator(window: window)

        Resolver.register { navCoordinator as AuthenticationNavigationCoordinator }
        authenticationUseCase.initializeNavigationEventListener()

        Resolver.register { self }
    }
    
    func handleSessionChange(newSession session: Session) {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.keyWindow else { return }
            let configuration = Resolver.resolve(AppConfiguration.self)
            configuration.router.didUpdateState(AppState(session))(window)

            let windowViewController: UIViewController
            let navigationController = UINavigationController()
            let authenticationUseCase = Resolver.resolve(AuthenticationUseCase.self)

            switch session {
            case .valid:
                windowViewController = Workspaces.buildSelector(navigationController: navigationController)
            case .none:
                if authenticationUseCase.isEnrolled {
                    windowViewController = Login.build(shouldAutoLogin: true)(navigationController)
                } else {
                    windowViewController = Register.build()(navigationController)
                }
            case .locked:
                windowViewController = Register.build(session: .locked)(navigationController)
            case .expired:
                windowViewController = Login.build(session: .expired)(navigationController)
            @unknown default:
                fatalError()
            }
            navigationController.viewControllers = [windowViewController]
            UIApplication.shared.keyWindow?.rootViewController = navigationController
        }
    }
}

extension Authentication.Configuration: Configurable {
    static var appDefault: Authentication.Configuration {
        return Authentication.Configuration()
    }
}

private extension AppState {
    init(_ session: Session) {
        let authenticationUseCase = Resolver.resolve(AuthenticationUseCase.self)
        switch session {
        case .valid:
            self = .loggedInEnrolled
        case .none:
            if authenticationUseCase.isEnrolled {
                self = .notLoggedInEnrolled
            } else {
                self = .notLoggedInNotEnrolled
            }
        case .locked:
            self = .accountLocked
        case .expired:
            self = .sessionExpired
        @unknown default:
            fatalError()
        }
    }
}
