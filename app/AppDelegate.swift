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
import RetailPaymentJourney

class AppDelegate: AppCommon.AppDelegate<Router> {
  
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        let flag = super.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        More.Configuration.appDefault.register()
        UserProfileJourney.UserProfile.appDefault.register()
        AccountsJourney.Configuration.appDefault.register()
        RetailPayment.Configuration.appDefault.register()
        
        return flag
    }
}
