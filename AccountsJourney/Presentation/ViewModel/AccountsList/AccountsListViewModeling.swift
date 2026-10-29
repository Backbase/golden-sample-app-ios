//
//  AccountsListViewModeling.swift
//  AccountsJourney
//

import Foundation
import Observation

/// Abstraction the SwiftUI accounts list depends on.
///
/// The screen is described by an observable `state` and the `searchText`, and is driven by `async`
/// methods, so SwiftUI can call them straight from `.task` and `.refreshable` and wait for them to finish.
@MainActor
protocol AccountsListViewModeling: AnyObject, Observable {
    // MARK: - State

    /// What the screen shows: loading until the first load has finished, then either the formatted and
    /// localised accounts or the error of the last load. Later loads keep showing the accounts, see
    /// ``AccountsListContent/isReloading``.
    var state: ViewState<AccountsListContent> { get }
    /// The text of the search field. Call ``submitSearch(debounce:)`` when it changes.
    var searchText: String { get set }

    /// The search has been performed and there is nothing to show.
    var isEmpty: Bool { get }

    // MARK: - API

    func select(accountID: String)
    /// To be called every time the screen appears.
    func screenDidAppear()
    /// Loads the accounts the first time it is called, and does nothing afterwards.
    func loadAccountsIfNeeded() async
    /// The user pulled to refresh: tracks it, then reloads like ``refresh()``.
    func pullToRefresh() async
    /// Reloads the unfiltered accounts, which clears the search.
    func refresh() async
    /// Loads the accounts matching ``searchText``, once the user has stopped typing for `debounce`.
    func submitSearch(debounce: Duration) async
}

extension AccountsListViewModeling {
    func submitSearch() async {
        await submitSearch(debounce: .milliseconds(500))
    }
}
