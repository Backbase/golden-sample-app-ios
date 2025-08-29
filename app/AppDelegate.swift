//
//  AppDelegate.swift
//  ios-golden-sample-app
//
//  Created by Backbase on 29/06/2023.
//

import UIKit
import Resolver
import AccessControlClient3Gen2
import AccountsJourney
import AppCommon
import ArrangementsClient2Gen2
import Backbase
import IdentityAuthenticationJourney
import BackbaseIdentity
import BusinessJourneyCommon
import BusinessWorkspacesJourney
import BusinessWorkspacesJourneyWorkspacesUseCase2
import RetailFeatureFilterUseCase
import RetailFeatureFilterAccessControlEntitlementsUseCase
import RetailMoreJourney
import UserProfileJourney

class AppDelegate: AppCommon.AppDelegate<Router> {
  
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        let flag = super.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        More.Configuration.appDefault.register()
        UserProfileJourney.UserProfile.appDefault.register()
        AccountsJourney.Configuration.appDefault.register()
        
        registerChallengeResponseResolver()
        
        return flag
    }
    
    private func registerChallengeResponseResolver() {
        guard let client = Backbase.authClient() as? BBIDAuthClient else {
            return
        }

        let context = BBIDRouterContext()
        // swiftlint:disable:next force_try
        try! client.addRouter(
            CustomRouter(testWindow: window, context: context))

        Backbase.register(authClient: client)

        let accessTokenResolver = BBOAuth2InvalidAccessTokenResolver()
        let identityResolver = BBIDChallengeResolver(
            authClient: client,
            extraHeaders: nil,
            scope: nil)
        let chainResolver = BBChainErrorResponseResolver(
            resolversChain: [
                accessTokenResolver,
                CustomStepUpResolver(client: client, testWindow: window),
                identityResolver,
            ]
        )
        // swiftlint:disable:next force_try
        try! client.register(challengeResponseResolver: chainResolver)
    }
}
