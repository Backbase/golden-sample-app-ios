//
//  ScreenViewEvent+Extensions.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 07/02/2024.
//

import Foundation
import BackbaseObservability

extension ScreenViewEvent {
    static let journey = "accounts_journey"
    
    static var accounts: ScreenViewEvent {
        ScreenViewEvent(name: "accounts", journey: journey)
    }
    
    static var accountDetails: ScreenViewEvent {
        ScreenViewEvent(name: "account_details", journey: journey)
    }
}
