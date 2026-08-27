//
//  Authentication.swift
//  AccountsJourney
//
//  Created by Backbase on 03/02/2025.
//

import UIKit
import Backbase
import Resolver
import IdentityAuthenticationJourney
import BackbaseAnimation
import BackbaseLottieAnimation

extension Authentication.Configuration: AppDependency {
    
    public func register(sessionChangeHandler: IdentityAuthenticationUseCase.SessionHandler?) {
        let authenticationUseCase = IdentityAuthenticationUseCase(sessionHandler: sessionChangeHandler)
        let sessionResolver = Authentication.InvalidRefreshTokenResolver(useCase: authenticationUseCase)
        try? authenticationUseCase.register(invalidRefreshTokenResolver: sessionResolver)
        Backbase.register(authClient: authenticationUseCase)
        
        Resolver.register { authenticationUseCase as AuthenticationUseCase }
        Resolver.register { LottieAnimationViewFactory.self as AnimationViewFactory.Type }
        
        setupAuthNavigationCoordinator()
        
        Resolver.register { self }
        
    }
    
    func setupAuthNavigationCoordinator() {
        guard let window = UIApplication.shared.mainKeyWindow else { fatalError("Failed to get window")}
        let authenticationNavCoordinator: AuthenticationNavigationCoordinator = Authentication.NavigationCoordinator(window: window)
        Resolver.register { authenticationNavCoordinator as AuthenticationNavigationCoordinator }
    }
}

extension Authentication.Configuration: Configurable {
    public static var appDefault: Authentication.Configuration {
        var configuration = Authentication.Configuration()
        configuration.login.v2.autoLoginEnabled = true
        return configuration
    }
}

// MARK: - Authentication InvalidRefreshTokenResolver

extension Authentication {
    final class InvalidRefreshTokenResolver: BBOAuth2InvalidRefreshTokenResolver {
        init(useCase: IdentityAuthenticationUseCase) {
            self.useCase = useCase
            super.init(authClient: useCase)
        }

        override func handle(
            _ response: URLResponse,
            data: Data,
            from request: URLRequest,
            delegate: ErrorResponseDelegate & NSObjectProtocol
        ) {
            useCase?.expireSession()
        }

        private weak var useCase: IdentityAuthenticationUseCase?
    }
}
