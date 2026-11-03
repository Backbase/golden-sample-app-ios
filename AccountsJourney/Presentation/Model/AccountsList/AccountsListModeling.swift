//
//  AccountsListModeling.swift
//  AccountsJourney
//

import ArrangementsClient2Gen2
import ClientCommonGen2
import Foundation

/// What the accounts list view model needs from the layer below it: the domain data, and the
/// navigation as an intent. It knows nothing about the screen.
@MainActor
protocol AccountsListModeling: AnyObject {
    /// Loads the accounts of the user.
    func fetchAccountSummary() async -> Result<ProductSummary, ErrorResponse>
    /// Shows the details of the account with the given id.
    func navigateToDetails(ofAccountWithID id: String)
}
