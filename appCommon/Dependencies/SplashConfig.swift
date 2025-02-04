//
//  SplashConfig.swift
//  AppCommon
//
//  Created by George Nyakundi on 04/02/2025.
//

import Foundation
import Resolver
import BackbaseDesignSystem
import BackbaseAnimation
import BackbaseLottieAnimation
import IdentityAuthenticationJourney

extension Splash.Configuration: AppDependency { }

extension Splash.Configuration: Configurable {
    public static var appDefault: Splash.Configuration {
        var configuration = Splash.Configuration()
        Resolver.register { LottieAnimationViewFactory.self as AnimationViewFactory.Type }
        
        configuration.router.didFinishWaiting = {
            let authenticationUseCase = Resolver.resolve(AuthenticationUseCase.self)
            authenticationUseCase.validateSession(callback: nil)
        }
        
        let source: AnimationSource = .bundle { _ in
            .init(resourceName: "splash_animation.json", in: .main)
        }
        
        configuration.splashScreenType = .animated(animationSource: .init(source: source), backgroundColor: .blue)
        return configuration
    }
}
