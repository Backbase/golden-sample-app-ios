//
//  AccountsDetailsError.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 28/11/2023.
//

import Foundation
import ClientCommonGen2

extension AccountDetails {
    public typealias ErrorFormatter<T> = MainErrorFormatter<AccountDetails.Error, T>
    
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
