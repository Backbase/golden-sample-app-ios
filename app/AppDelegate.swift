//
//  AppDelegate.swift
//  ios-golden-sample-app
//
//  Created by Backbase on 29/06/2023.
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
import ArrangementsClient2Gen2
import AppCommon
import RetailMoreJourney
import UserProfileJourney
import AccountsJourney

class AppDelegate: AppCommon.AppDelegate<Router> {
    
    override init() {
        super.init()
    }
    
    override func application(_ application: UIApplication,
                              didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        let flag = super.application(application, didFinishLaunchingWithOptions: launchOptions)
        More.Configuration.appDefault.register()
        UserProfileJourney.UserProfile.appDefault.register()
        AccountsJourney.Configuration.appDefault.register()
        
        return flag
    }
}

//class AppDelegate: UIResponder, UIApplicationDelegate {
//
//    var window: UIWindow?
//    
//    // MARK: Properties
//    lazy var productSummaryClient = clientFactory(ArrangementsClient2Gen2.ProductSummaryAPI(), "api/arrangement-manager")
//    lazy var arrangementsClient = clientFactory(ArrangementsClient2Gen2.ArrangementsAPI(), "api/arrangement-manager")
//    
//    // MARK: Identity Journey properties
//
//    lazy var authenticationUseCase: IdentityAuthenticationUseCase = { [weak self] in
//        let useCase = IdentityAuthenticationUseCase(sessionChangeHandler: self?.handleSessionChange(newSession:))
//        Backbase.register(authClient: useCase)
//
//        Resolver.register { Authentication.Configuration() }
//        Resolver.register { useCase as AuthenticationUseCase }
//
//        return useCase
//    }()
//
//    lazy var authenticationConfiguration: Authentication.Configuration = {
//        var config = Authentication.Configuration()
//        config.login.autoLoginEnabled = true
//        return config
//    }()
//
//    lazy var navCoordinator: AuthenticationNavigationCoordinator = { [weak self] in
//        guard let window = self?.window else { fatalError("Failed to get window") }
//        return Authentication.NavigationCoordinator(window: window)
//    }()
//
//    // MARK: Default methods
//
//    func application(_ application: UIApplication,
//                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // Override point for customisation after application launch.
//        let window = UIWindow()
//        window.rootViewController = UIViewController()
//        window.makeKeyAndVisible()
//        self.window = window
//
//        setupBackbaseSDK()
//        setupIdentityJourney()
//        setupWorkspacesJourney()
//        setupAccountsJourney()
//        UserProfileUseCaseHelper().setupUserProfileUseCase()
//        MoreMenuConfiguration.setupMoreMenu()
//        return true
//    }
//}
