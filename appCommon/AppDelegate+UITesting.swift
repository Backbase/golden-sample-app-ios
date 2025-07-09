//
//  AppDelegate+UITesting.swift
//  ios-golden-sample-app
//
//  Created by George Nyakundi on 02/06/2025.
//
import Foundation
import UIKit
import Resolver
import AccountsJourney
import IdentityAuthenticationJourney
import ClientCommonGen2


extension AppDelegate {
    func setupRouter(with window: UIWindow) {
        let router = Router()
        Resolver.register { router }.implements(AppRouter.self)

        Authentication.Configuration.appDefault.register(sessionChangeHandler: router.handleSessionChange)
        router.didStartApp(window: window)
    }
}

extension CallError {
    static func errorFromString(_ str: String) -> Self {
        if str == "nilHTTPResponse" {
            return CallError.nilHTTPResponse(nil)
        }

        return .emptyDataResponse
    }
}

extension AppDelegate {
    func prepareForUITesting() {
        if ProcessInfo.processInfo.arguments.contains("UITests") {
            UIView.setAnimationsEnabled(false)
            window?.layer.speed = 100
        }
    }

    func shouldUseMocks() -> Bool {
        return ProcessInfo.processInfo.arguments.contains("UseMocks")
    }
}


