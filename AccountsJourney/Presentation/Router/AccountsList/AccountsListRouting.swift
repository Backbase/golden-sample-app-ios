//
//  AccountsListRouting.swift
//  AccountsJourney
//

import Foundation

/// The navigation the accounts list can trigger. It is owned by the model, so that
/// neither the view nor the view model know how, or where to, the journey navigates.
@MainActor
protocol AccountsListRouting {
    /// Shows the details of the account with the given id.
    func navigateToDetails(ofAccountWithID id: String)
}
