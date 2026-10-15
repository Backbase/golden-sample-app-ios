//
//  AccountsListViewModel.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 12/10/2023.
//

import ArrangementsClient2Gen2
import BackbaseObservability
import ClientCommonGen2
import Foundation
import Observation

/// Drives the SwiftUI accounts list.
///
/// The screen is described by plain observable properties (`rows`, `isLoading`, `error`,
/// `searchText`) and is driven by `async` methods, so SwiftUI can call them straight from
/// `.task` and `.refreshable` and wait for them to finish.
@MainActor
@Observable
final class AccountsListViewModel: AccountsListViewModeling {

    // MARK: - State

    /// Accounts matching the last submitted search, in display order. What `rows` are mapped from.
    private(set) var accounts = [AccountData]()
    /// What the list shows for `accounts`: formatted and localised, in the same order.
    private(set) var rows = [AccountsListRowContent]()
    /// `true` until the first load has finished, and while any later load is in flight.
    private(set) var isLoading = true
    /// Set when the last load failed. The accounts are cleared in that case.
    private(set) var error: AccountsList.Error?
    /// The text of the search field. Call ``submitSearch(debounce:)`` when it changes.
    var searchText = ""

    /// The search has been performed and there is nothing to show.
    var isEmpty: Bool {
        !isLoading && error == nil && rows.isEmpty
    }

    // MARK: - Dependencies

    @ObservationIgnored private let model: AccountsListModeling
    @ObservationIgnored private let configuration: AccountsJourney.Configuration
    @ObservationIgnored private let tracker: BackbaseObservability.Tracker?
    @ObservationIgnored private let contentMapper: AccountsListContentMapper

    // MARK: - Private

    /// The query of the latest load, so the same search is not performed twice.
    @ObservationIgnored private var submittedQuery = ""
    @ObservationIgnored private var hasLoaded = false
    /// Identifies the latest load, so the answer of a superseded one can be dropped.
    @ObservationIgnored private var latestLoadID = 0

    // MARK: - Init

    /// - Parameters:
    ///   - model: Provides the accounts and navigates to the one the user selects.
    ///   - configuration: Provides the strings and icons the accounts are mapped with.
    ///   - tracker: Receives the analytics events. `nil` disables tracking.
    ///   - contentMapper: Formats and localises the accounts for the screen. Defaults to a mapper
    ///     using the strings of `configuration`.
    init(
        model: AccountsListModeling,
        configuration: AccountsJourney.Configuration,
        tracker: BackbaseObservability.Tracker? = nil,
        contentMapper: AccountsListContentMapper? = nil
    ) {
        self.model = model
        self.configuration = configuration
        self.tracker = tracker
        self.contentMapper = contentMapper ?? AccountsListContentMapper(strings: configuration.accountsList.strings)
    }

    // MARK: - Methods

    func select(accountID: String) {
        model.navigateToDetails(ofAccountWithID: accountID)
    }

    /// To be called every time the screen appears.
    func screenDidAppear() {
        tracker?.publish(event: ScreenViewEvent(.accountsList))
    }

    /// Loads the accounts the first time it is called, and does nothing afterwards.
    func loadAccountsIfNeeded() async {
        guard !hasLoaded else { return }
        hasLoaded = true
        await load(query: "")
    }

    /// The user pulled to refresh: tracks it, then reloads like ``refresh()``.
    func pullToRefresh() async {
        tracker?.publish(event: UserActionEvent(.refreshAccounts))
        await refresh()
    }

    /// Reloads the unfiltered accounts, which clears the search. Returns once the reload has finished,
    /// which is what `refreshable` needs to know when to dismiss the pull to refresh indicator.
    func refresh() async {
        searchText = ""
        await load(query: "")
    }

    /// Loads the accounts matching ``searchText``, once the user has stopped typing for `debounce`.
    ///
    /// Meant for `.task(id: searchText)`: SwiftUI cancels it on every keystroke, which ends the wait.
    func submitSearch(debounce: Duration = .milliseconds(500)) async {
        guard searchText != submittedQuery else { return }
        try? await Task.sleep(for: debounce)
        guard !Task.isCancelled, searchText != submittedQuery else { return }
        await load(query: searchText)
    }

    // MARK: - Private

    private func load(query: String) async {
        latestLoadID += 1
        let loadID = latestLoadID
        submittedQuery = query
        error = nil
        isLoading = true

        let result = await model.fetchAccountSummary()

        // A newer load is in flight, and owns `isLoading` and the results.
        guard loadID == latestLoadID else { return }
        isLoading = false

        switch result {
        case let .success(accountsSummaryResponse):
            let summary = accountsSummaryResponse.toMapUI(configuration: configuration)
            accounts = Self.filter(AccountsListOrdering.orderedAccounts(from: summary), by: query)
            rows = contentMapper.rows(for: accounts)
        case let .failure(errorResponse):
            // Don't keep showing accounts from a previous load once it has failed. The error
            // replaces the list, and with it the search field, so the search is cleared too.
            accounts = []
            rows = []
            error = .loadingFailure(errorResponse)
            searchText = ""
            submittedQuery = ""
        }
    }

    // MARK: - Search

    /// The accounts whose name contains `query`, ignoring case and surrounding whitespace.
    /// Every account matches an empty query, and an account without a name never matches a query.
    nonisolated static func filter(_ accounts: [AccountData], by query: String) -> [AccountData] {
        let searchQuery = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !searchQuery.isEmpty else { return accounts }
        return accounts.filter { $0.name?.lowercased().contains(searchQuery) == true }
    }
}
