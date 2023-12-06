//
//  AccountsDetailsError.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 28/11/2023.
//

import Foundation
import Resolver
import ClientCommonGen2

extension AccountDetails {
    /// Generic ErrorFormatter
    public typealias ErrorFormatter<T> = MainErrorFormatter<AccountDetails.Error, T>
    
    /// Possible errors
    public enum Error: Swift.Error, Equatable {
        case invalidResponse
        case notConnected
        case loadingFailure(_ response: AccountsJourney.ErrorResponse? = nil)
    }
    
    static func getError(_ error: Swift.Error, response: AccountsJourney.ErrorResponse?) -> AccountDetails.Error {
        switch error as? ClientCommonGen2.CallError {
        case .nilHTTPResponse:
            return AccountDetails.Error.notConnected
        default:
            return AccountDetails.Error.loadingFailure(response)
        }
    }
}

extension AccountDetails.Error {
    /// Name of the icon
    public var icon: String? {
        let config: AccountsJourney.Configuration = Resolver.resolve()
        return config.accountDetails.design.errorIconName(self)
    }
    /// Title for the given error
    public var title: String {
        let config: AccountsJourney.Configuration = Resolver.resolve()
        return config.accountDetails.strings.errorTitle(self)()
    }
    
    /// Subtitle for the given error
    public var subtitle: String {
        let config: AccountsJourney.Configuration = Resolver.resolve()
        return config.accountDetails.strings.errorSubtitle(self)()
    }
    
    /// Action button title for the given error
    public var actionButtonTitle: String? {
        let config: AccountsJourney.Configuration = Resolver.resolve()
        return config.accountDetails.strings.errorRetryButtonTitle(self)?()
    }
}
