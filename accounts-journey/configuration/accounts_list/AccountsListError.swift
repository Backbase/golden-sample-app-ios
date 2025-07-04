//
//  AccountsListError.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 27/11/2023.
//

import Foundation
import Resolver
import ClientCommonGen2

extension AccountsList {
    /// Account list ErrorFormatter
    public typealias ErrorFormatter<T> = MainErrorFormatter<AccountsList.Error, T>
    
    /// Accounts lists possible errors
    public enum Error: Swift.Error {
        case invalidResponse
        case notConnected
        case noAccounts
        case loadingFailure(_ response: ErrorResponse? = nil)
    }
    
    static func getError(_ error: Swift.Error, response: ErrorResponse?) -> AccountsList.Error {
        switch error as? ClientCommonGen2.CallError {
        case .nilHTTPResponse:
            return AccountsList.Error.notConnected
        default:
            return AccountsList.Error.loadingFailure(response)
        }
    }
}

extension AccountsList.Error {
    /// Name of the icon
    public var icon: String? {
        let config: AccountsJourney.Configuration = Resolver.resolve()
        return config.accountsList.design.errorIconName(self)
    }
    /// Title for the given error
    public var title: String {
        let config: AccountsJourney.Configuration = Resolver.resolve()
        return config.accountsList.strings.errorTitle(self)()
    }
    
    /// Subtitle for the given error
    public var subtitle: String {
        let config: AccountsJourney.Configuration = Resolver.resolve()
        return config.accountsList.strings.errorSubtitle(self)()
    }
    
    /// Action button title for the given error
    public var actionButtonTitle: String? {
        let config: AccountsJourney.Configuration = Resolver.resolve()
        return config.accountsList.strings.errorRetryButtonTitle(self)?()
    }
}
