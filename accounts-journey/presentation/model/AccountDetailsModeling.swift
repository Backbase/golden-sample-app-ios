//
//  AccountDetailsModeling.swift
//  AccountsJourney
//

import ArrangementsClient2Gen2
import ClientCommonGen2
import Foundation

/// What the account details view model needs from the layer below it: the domain data of the account.
/// It knows nothing about the screen.
@MainActor
protocol AccountDetailsModeling: AnyObject {
    /// Loads the account the screen shows.
    func fetchAccountDetail() async -> Result<AccountArrangementItem, ErrorResponse>
}
