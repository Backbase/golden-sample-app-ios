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
/// The screen is described by plain observable properties (`content`, `isLoading`, `error`) and is
/// driven by `async` methods, so SwiftUI can call them straight from `.task` and wait for them to finish.
@MainActor
@Observable
final class AccountDetailsViewModel: AccountDetailsViewModeling {

    // MARK: - State

    /// The loaded account, `nil` while loading and after a failure. What `content` is mapped from.
    private(set) var details: AccountDetailsData?
    /// What the screen shows for `details`: formatted and localised, `nil` whenever `details` is.
    private(set) var content: AccountDetailsContent?
    /// `true` until the first load has finished, and while any later load is in flight.
    private(set) var isLoading = true
    /// Set when the last load failed.
    private(set) var error: AccountDetails.Error?

    // MARK: - Dependencies

    @ObservationIgnored private let model: AccountDetailsModeling
    @ObservationIgnored private let configuration: AccountsJourney.Configuration
    @ObservationIgnored private let tracker: BackbaseObservability.Tracker?
    @ObservationIgnored private let contentMapper: AccountDetailsContentMapper

    // MARK: - Private

    @ObservationIgnored private var hasLoaded = false
    /// Identifies the latest load, so the answer of a superseded one can be dropped.
    @ObservationIgnored private var latestLoadID = 0

    // MARK: - Init

    /// - Parameters:
    ///   - model: Provides the account to show.
    ///   - configuration: Provides the strings and icons the account is mapped with.
    ///   - tracker: Receives the analytics events. `nil` disables tracking.
    ///   - contentMapper: Formats and localises the account for the screen. Defaults to a mapper
    ///     using the strings of `configuration`.
    init(
        model: AccountDetailsModeling,
        configuration: AccountsJourney.Configuration,
        tracker: BackbaseObservability.Tracker? = nil,
        contentMapper: AccountDetailsContentMapper? = nil
    ) {
        self.model = model
        self.configuration = configuration
        self.tracker = tracker
        self.contentMapper = contentMapper ?? AccountDetailsContentMapper(strings: configuration.accountDetails.strings)
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

        let result = await model.fetchAccountDetail()

        // A newer load is in flight, and owns `isLoading` and the results.
        guard loadID == latestLoadID else { return }
        isLoading = false

        switch result {
        case let .success(accountDetailsResponse):
            let details = accountDetailsResponse.toMapUI(configuration: configuration)
            self.details = details
            content = contentMapper.content(for: details)
        case let .failure(errorResponse):
            details = nil
            content = nil
            error = .loadingFailure(errorResponse)
        }
    }
}
