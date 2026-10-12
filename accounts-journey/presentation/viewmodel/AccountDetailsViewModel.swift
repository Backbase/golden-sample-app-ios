//
//  AccountDetailsViewModel.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 29/11/2023.
//

import ArrangementsClient2Gen2
import BackbaseObservability
import ClientCommonGen2
import Foundation
import Observation

/// Drives the SwiftUI account details.
///
/// The screen is described by plain observable properties (`details`, `isLoading`, `error`) and is
/// driven by `async` methods, so SwiftUI can call them straight from `.task` and wait for them to finish.
@MainActor
@Observable
final class AccountDetailsViewModel {

    // MARK: - State

    /// The loaded account, `nil` while loading and after a failure.
    private(set) var details: AccountDetailsUIModel?
    /// `true` until the first load has finished, and while any later load is in flight.
    private(set) var isLoading = true
    /// Set when the last load failed.
    private(set) var error: AccountDetails.Error?

    // MARK: - Dependencies

    @ObservationIgnored private let arrangementId: String
    @ObservationIgnored private let useCase: AccountDetailsUseCase
    @ObservationIgnored private let configuration: AccountsJourney.Configuration
    @ObservationIgnored private let tracker: BackbaseObservability.Tracker?

    // MARK: - Private

    @ObservationIgnored private var hasLoaded = false
    /// Identifies the latest load, so the answer of a superseded one can be dropped.
    @ObservationIgnored private var latestLoadID = 0

    // MARK: - Init

    /// - Parameters:
    ///   - arrangementId: The id of the account to show.
    ///   - useCase: Loads the account.
    ///   - configuration: Provides the strings and icons the account is mapped with.
    ///   - tracker: Receives the analytics events. `nil` disables tracking.
    init(
        arrangementId: String,
        useCase: AccountDetailsUseCase,
        configuration: AccountsJourney.Configuration,
        tracker: BackbaseObservability.Tracker? = nil
    ) {
        self.arrangementId = arrangementId
        self.useCase = useCase
        self.configuration = configuration
        self.tracker = tracker
    }

    // MARK: - Methods

    /// To be called every time the screen appears.
    func screenDidAppear() {
        tracker?.publish(event: ScreenViewEvent(.accountDetails))
    }

    /// Loads the account the first time it is called, and does nothing afterwards.
    func loadIfNeeded() async {
        guard !hasLoaded else { return }
        hasLoaded = true
        await load()
    }

    /// Loads the account, whether it has been loaded before or not. Also what the retry button runs.
    func load() async {
        hasLoaded = true
        latestLoadID += 1
        let loadID = latestLoadID
        error = nil
        isLoading = true

        let result = await fetchAccountDetail()

        // A newer load is in flight, and owns `isLoading` and the results.
        guard loadID == latestLoadID else { return }
        isLoading = false

        switch result {
        case let .success(accountDetailsResponse):
            details = accountDetailsResponse.toMapUI(configuration: configuration)
        case let .failure(errorResponse):
            details = nil
            error = .loadingFailure(errorResponse)
        }
    }

    // MARK: - Private

    private func fetchAccountDetail() async -> Result<AccountArrangementItem, ErrorResponse> {
        let useCase = useCase
        let arrangementId = arrangementId
        return await withCheckedContinuation { continuation in
            useCase.getAccountDetail(arrangementId: arrangementId) { continuation.resume(returning: $0) }
        }
    }
}
