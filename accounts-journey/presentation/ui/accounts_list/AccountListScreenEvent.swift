//
//  AccountListEvent.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 17/11/2023.
//

import Foundation

/// All possible events from the AccountsListScreen
public enum AccountListScreenEvent {
    /// Load accounts
    case getAccounts
    /// Refresh accounts loaded
    case refresh
    /// Search for an account
    case search(String)
}

extension AccountListScreenEvent: Equatable {}
