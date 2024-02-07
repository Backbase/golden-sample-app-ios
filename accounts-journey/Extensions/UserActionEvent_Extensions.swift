//
//  UserActionEvent_Extensions.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 07/02/2024.
//

import Foundation
import BackbaseObservability

extension UserActionEvent {
    static let journey = "accounts_journey"
    
    static var refresh: UserActionEvent {
        UserActionEvent(name: "refresh_accounts", journey: journey)
    }
    
    static var searchAccounts: UserActionEvent {
        UserActionEvent(name: "search_accounts", journey: journey)
    }
}
