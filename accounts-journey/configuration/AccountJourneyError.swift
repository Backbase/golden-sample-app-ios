//
//  AccountJourneyError.swift
//  AccountsJourney
//
//  Created by George Nyakundi on 13/11/2023.
//


import UIKit
import Foundation
import Resolver
import ClientCommonGen2

public typealias MainErrorFormatter<E: Error, T> = (E) -> T

public extension AccountsJourney {
    
    typealias ErrorFormatter<T> = MainErrorFormatter<AccountsJourney.Error, T>
    
    enum Error: Swift.Error, Equatable {
        case notConnected
        case noAccounts
        case loadingFailure(_ response: ErrorResponse? = nil)
    }
    
    static func getError(_ error: Swift.Error, response: ErrorResponse?) -> AccountsJourney.Error {
        switch error as? ClientCommonGen2.CallError {
        case .nilHTTPResponse:
            return AccountsJourney.Error.notConnected
        default:
            return AccountsJourney.Error.loadingFailure(response)
        }
    }
}

extension AccountsJourney.Error {
    /// Name of the icon
    public var icon: String? {
        let config: AccountsJourney.Configuration = Resolver.resolve()
        return config.design.errorIconName(self)
    }
    /// Title for the given error
    public var title: String {
        let config: AccountsJourney.Configuration = Resolver.resolve()
        return config.strings.errorTitle(self)()
    }
    
    /// Subtitle for the given error
    public var subtitle: String {
        let config: AccountsJourney.Configuration = Resolver.resolve()
        return config.strings.errorSubtitle(self)()
    }
    
    /// Action button title for the given error
    public var actionButtonTitle: String? {
        let config: AccountsJourney.Configuration = Resolver.resolve()
        return config.strings.errorRetryButtonTitle(self)?()
    }
}
