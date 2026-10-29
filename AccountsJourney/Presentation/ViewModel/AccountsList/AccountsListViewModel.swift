//
//  AccountsListViewModel.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 12/10/2023.
//

import ArrangementsClient2Gen2
import BackbaseDesignSystem
import BackbaseObservability
import ClientCommonGen2
import Foundation
import Observation

/// Drives the SwiftUI accounts list.
///
/// The screen is described by an observable `state` and the `searchText`, and is driven by `async`
/// methods, so SwiftUI can call them straight from `.task` and `.refreshable` and wait for them to finish.
@MainActor
@Observable
final class AccountsListViewModel: AccountsListViewModeling {

    // MARK: - State

    /// Accounts matching the last submitted search, in display order. What the content is mapped from.
    private(set) var accounts = [AccountData]()
    /// Full unfiltered accounts from the last network fetch. Used to filter locally on search, avoiding
    /// redundant network calls for every keystroke.
    @ObservationIgnored private var allAccounts = [AccountData]()
    /// What the screen shows: loading until the first load has finished, then either the formatted and
    /// localised accounts or the error of the last load. Later loads keep showing the accounts, see
    /// ``AccountsListContent/isReloading``.
    private(set) var state: ViewState<AccountsListContent> = .loading
    /// The text of the search field. Call ``submitSearch(debounce:)`` when it changes.
    var searchText = ""

    /// The search has been performed and there is nothing to show.
    var isEmpty: Bool {
        state.data?.isEmpty ?? false
    }

    // MARK: - Dependencies

    @ObservationIgnored private let model: AccountsListModeling
    @ObservationIgnored private let configuration: AccountsJourney.Configuration
    @ObservationIgnored private let tracker: BackbaseObservability.Tracker?
    @ObservationIgnored private let contentMapper: AccountsListContentMapper
    @ObservationIgnored private let errorMapper: AccountsListErrorConfigurationMapper

    // MARK: - Private

    /// The query of the latest load, so the same search is not performed twice.
    @ObservationIgnored private var submittedQuery = ""
    @ObservationIgnored private let loadCoordinator = LoadCoordinator()

    // MARK: - Init

    /// - Parameters:
    ///   - model: Provides the accounts and navigates to the one the user selects.
    ///   - configuration: Provides the strings and icons the accounts are mapped with.
    ///   - tracker: Receives the analytics events. `nil` disables tracking.
    ///   - contentMapper: Formats and localises the accounts for the screen. Defaults to a mapper
    ///     using the strings of `configuration`.
    ///   - errorMapper: Builds what the error state shows. Defaults to a mapper using the strings and
    ///     the design of `configuration`.
    init(
        model: AccountsListModeling,
        configuration: AccountsJourney.Configuration,
        tracker: BackbaseObservability.Tracker? = nil,
        contentMapper: AccountsListContentMapper? = nil,
        errorMapper: AccountsListErrorConfigurationMapper? = nil
    ) {
        self.model = model
        self.configuration = configuration
        self.tracker = tracker
        self.contentMapper = contentMapper ?? AccountsListContentMapper(strings: configuration.accountsList.strings)
        self.errorMapper = errorMapper ?? AccountsListErrorConfigurationMapper(journeyConfiguration: configuration)
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
        guard loadCoordinator.beginFirstLoad() else { return }
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
    /// If accounts have already been fetched, the search is resolved locally from `allAccounts` to
    /// avoid redundant network requests on every keystroke.
    func submitSearch(debounce: Duration = .milliseconds(500)) async {
        guard searchText != submittedQuery else { return }
        try? await Task.sleep(for: debounce)
        guard !Task.isCancelled, searchText != submittedQuery else { return }
        // Apply local filtering when accounts are already on screen — no network call needed.
        if case .loaded = state, !allAccounts.isEmpty {
            submittedQuery = searchText
            accounts = Self.filter(allAccounts, by: searchText)
            state = .loaded(AccountsListContent(rows: contentMapper.rows(for: accounts)))
        } else {
            await load(query: searchText)
        }
    }

    // MARK: - Private

    private func load(query: String) async {
        let loadToken = loadCoordinator.beginLoad()
        submittedQuery = query
        // Accounts that are on screen stay there while the new ones load. Anything else, which is
        // the first load or the one after a failure, shows the spinner.
        if case let .loaded(content) = state {
            state = .loaded(AccountsListContent(rows: content.rows, isReloading: true))
        } else {
            state = .loading
        }

        let result = await model.fetchAccountSummary()

        // A newer load is in flight, and owns the state.
        guard loadCoordinator.isCurrent(loadToken) else { return }

        switch result {
        case let .success(accountsSummaryResponse):
            let summary = accountsSummaryResponse.toMapUI(configuration: configuration)
            allAccounts = AccountsListOrdering.orderedAccounts(from: summary)
            accounts = Self.filter(allAccounts, by: query)
            state = .loaded(AccountsListContent(rows: contentMapper.rows(for: accounts)))
        case let .failure(errorResponse):
            // Don't keep showing accounts from a previous load once it has failed. The error
            // replaces the list, and with it the search field, so the search is cleared too.
            accounts = []
            allAccounts = []
            // The retry button reloads the unfiltered accounts.
            state = .error(errorMapper.stateViewConfiguration(for: .loadingFailure(errorResponse)) { [weak self] in
                Task { await self?.refresh() }
            })
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
