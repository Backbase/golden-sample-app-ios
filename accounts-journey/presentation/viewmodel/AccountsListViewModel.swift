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
/// The screen is described by plain observable properties (`accounts`, `isLoading`, `error`,
/// `searchText`) and is driven by `async` methods, so SwiftUI can call them straight from
/// `.task` and `.refreshable` and wait for them to finish.
@MainActor
@Observable
final class AccountsListViewModel {

    // MARK: - State

    /// Accounts matching the last submitted search, in display order.
    private(set) var accounts = [AccountUIModel]()
    /// `true` until the first load has finished, and while any later load is in flight.
    private(set) var isLoading = true
    /// Set when the last load failed. The accounts are cleared in that case.
    private(set) var error: AccountsList.Error?
    /// The text of the search field. Call ``submitSearch(debounce:)`` when it changes.
    var searchText = ""

    /// The search has been performed and there is nothing to show.
    var isEmpty: Bool {
        !isLoading && error == nil && accounts.isEmpty
    }

    // MARK: - Dependencies

    @ObservationIgnored private let useCase: AccountsListUseCase
    @ObservationIgnored private let configuration: AccountsJourney.Configuration
    @ObservationIgnored private let tracker: BackbaseObservability.Tracker?
    @ObservationIgnored private let didSelectProduct: (String) -> Void

    // MARK: - Private

    /// The query of the latest load, so the same search is not performed twice.
    @ObservationIgnored private var submittedQuery = ""
    @ObservationIgnored private var hasLoaded = false
    /// Identifies the latest load, so the answer of a superseded one can be dropped.
    @ObservationIgnored private var latestLoadID = 0

    // MARK: - Init

    /// - Parameters:
    ///   - useCase: Loads the accounts.
    ///   - configuration: Provides the strings and icons the accounts are mapped with.
    ///   - tracker: Receives the analytics events. `nil` disables tracking.
    ///   - didSelectProduct: Routes to the product with the given id.
    init(
        useCase: AccountsListUseCase,
        configuration: AccountsJourney.Configuration,
        tracker: BackbaseObservability.Tracker? = nil,
        didSelectProduct: @escaping (String) -> Void = { _ in }
    ) {
        self.useCase = useCase
        self.configuration = configuration
        self.tracker = tracker
        self.didSelectProduct = didSelectProduct
    }

    // MARK: - Methods

    func select(accountID: String) {
        didSelectProduct(accountID)
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

        let result = await fetchAccountSummary()

        // A newer load is in flight, and owns `isLoading` and the results.
        guard loadID == latestLoadID else { return }
        isLoading = false

        switch result {
        case let .success(accountsSummaryResponse):
            accounts = accountsSummaryResponse
                .toMapUI(configuration: configuration)
                .generateList(query: query)
        case let .failure(errorResponse):
            // Don't keep showing accounts from a previous load once it has failed. The error
            // replaces the list, and with it the search field, so the search is cleared too.
            accounts = []
            error = .loadingFailure(errorResponse)
            searchText = ""
            submittedQuery = ""
        }
    }

    private func fetchAccountSummary() async -> Result<ProductSummary, ErrorResponse> {
        let useCase = useCase
        return await withCheckedContinuation { continuation in
            useCase.getAccountSummary { continuation.resume(returning: $0) }
        }
    }
}
