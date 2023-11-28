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
    public typealias ErrorFormatter<T> = MainErrorFormatter<AccountsList.Error, T>
    
    public enum Error: Swift.Error, Equatable {
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

extension AccountsList {
    public struct ErrorResponse: Swift.Error, Equatable {
        /// Status code of the error
        public let statusCode: Int?
        /// Response data
        public let data: Data?
        /// Error
        public let error: Swift.Error?
        
        /**
         * Initialiser for the `ErrorResponse` DTO.
         * - Parameters statusCode: Status code of the error
         * - Parameters data: Response data.
         * - Parameters error: Error
         * - returns initialised `ErrorResponse` object.
         */
        public init(statusCode: Int? = nil, data: Data? = nil, error: Swift.Error? = nil) {
            self.statusCode = statusCode
            self.data = data
            self.error = error
        }
        
        public static func == (lhs: ErrorResponse, rhs: ErrorResponse) -> Bool {
            return lhs.statusCode == rhs.statusCode &&
            lhs.data == rhs.data &&
            lhs.error?.localizedDescription == rhs.error?.localizedDescription
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
