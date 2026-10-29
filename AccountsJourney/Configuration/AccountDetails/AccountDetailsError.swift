//
//  AccountsDetailsError.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 28/11/2023.
//

import Foundation
import ClientCommonGen2

extension AccountDetails {
    /// Account Details ErrorFormatter
    public typealias ErrorFormatter<T> = MainErrorFormatter<AccountDetails.Error, T>
    
    /// Possible errors
    public enum Error: Swift.Error {
        case invalidResponse
        case notConnected
        case loadingFailure(_ response: ClientCommonGen2.ErrorResponse? = nil)
    }
    
    static func getError(_ error: Swift.Error, response: ClientCommonGen2.ErrorResponse?) -> AccountDetails.Error {
        switch error as? ClientCommonGen2.CallError {
        case .nilHTTPResponse:
            return AccountDetails.Error.notConnected
        default:
            return AccountDetails.Error.loadingFailure(response)
        }
    }
}
