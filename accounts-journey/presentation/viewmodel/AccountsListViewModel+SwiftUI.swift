//
//  AccountsListViewModel+SwiftUI.swift
//  AccountsJourney
//

import Combine

// MARK: - SwiftUI support

/// `AccountsListViewModel` is shared by `AccountsListViewController` and `AccountsListView`.
/// Everything the SwiftUI screen needs on top of the UIKit one lives here.
extension AccountsListViewModel {

    /// Reloads the accounts and returns once the reload has finished, which is what
    /// `refreshable` needs to know when to dismiss the pull to refresh indicator.
    func refreshAccounts() async {
        onEvent(.refresh)
        _ = await $screenState.values.first { !$0.isLoading }
    }
}
