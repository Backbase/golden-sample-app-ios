//
//  StubAccountsListRouting.swift
//  SnapshotTests
//

import Foundation
@testable import AccountsJourney

/// An `AccountsListRouting` that goes nowhere: the snapshots only render the screen.
@MainActor
struct StubAccountsListRouting: AccountsListRouting {
    func navigateToDetails(ofAccountWithID id: String) {}
}
