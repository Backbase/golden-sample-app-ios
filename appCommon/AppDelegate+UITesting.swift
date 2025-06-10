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
import MockedAccountsUseCase
import IdentityAuthenticationJourney
import ClientCommonGen2


extension AppDelegate {
    func setupRouter(with window: UIWindow) {
        if shouldUseMocks() {
            prepareForUITesting()
            let router = MockedAppRouter()
            Resolver.register { router }.implements(AppRouter.self)
            if let error = ProcessInfo.processInfo.environment["hasError"] {
                let callError = CallError.errorFromString(error)
                let mockedAccountsUseCase = MockedAccountsUseCase(responseType: .failure(callError))
                Resolver.register { mockedAccountsUseCase as AccountsListUseCase }
            } else {
                Resolver.register { MockedAccountsUseCase(responseType: .success(())) as AccountsListUseCase }
            }

            Resolver.register { AccountsJourney.Configuration() }
            router.didStartApp(window: window)
        } else {
            let router = Router()
            Resolver.register { router }.implements(AppRouter.self)

            Authentication.Configuration.appDefault.register(sessionChangeHandler: router.handleSessionChange)
            router.didStartApp(window: window)
        }
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


