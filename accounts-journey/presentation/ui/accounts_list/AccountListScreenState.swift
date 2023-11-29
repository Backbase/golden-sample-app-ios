//
//  AccountListScreenState.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 17/11/2023.
//

import Foundation
import BackbaseDesignSystem

/// Enum representing the possible states of the AccountList Screen
public enum AccountListScreenState {
    /// Loading / searching
    case loading
    /// Idle state
    case loaded
    /// Empty results
    case emptyResults(StateViewConfiguration)
    /// Error has been encountered
    case hasError(StateViewConfiguration)
}
