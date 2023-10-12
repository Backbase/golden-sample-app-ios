//
//  AccountsJourneyError.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 12/10/2023.
//

import Foundation

extension AccountsJourney {
    enum Error: Swift.Error {
        case invalidResponse
        case emptyResponse
    }
    
}
