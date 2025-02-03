//
//  Authentication.swift
//  AccountsJourney
//
//  Created by George Nyakundi on 03/02/2025.
//

import UIKit
import Backbase
import Resolver
import IdentityAuthenticationJourney

extension Authentication.Configuration: AppDependency {
    
    public func register(sessionChangeHandler: IdentityAuthenticationUseCase.SessionHandler?) {
        let authenticationUseCase = IdentityAuthenticationUseCase(sessionChangeHandler: sessionChangeHandler)
        Backbase.register(authClient: authenticationUseCase)
        
        setupAuthNavigationCoordinator()
        
        var configuration = Authentication.Configuration()
        configuration.login.autoLoginEnabled = true
        
        Resolver.register { configuration as Authentication.Configuration }
        Resolver.register { authenticationUseCase as AuthenticationUseCase }
        
        Resolver.register { self }
        
    }
    
    func setupAuthNavigationCoordinator() {
        guard let window = UIApplication.shared.mainKeyWindow else { fatalError("Failed to get window")}
        let authenticationNavCoordinator: AuthenticationNavigationCoordinator = Authentication.NavigationCoordinator(window: window)
        Resolver.register { authenticationNavCoordinator as AuthenticationNavigationCoordinator }
        // TODO: Temporary call to `validateSession()` might need to move this somewhere else
        let authenticationUseCase: AuthenticationUseCase = Resolver.resolve()
        authenticationUseCase.validateSession { _ in }
    }
}
