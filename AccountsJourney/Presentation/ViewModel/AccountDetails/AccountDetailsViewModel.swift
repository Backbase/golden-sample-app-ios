//
//  AccountDetailsViewModel.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 29/11/2023.
//

import ArrangementsClient2Gen2
import BackbaseDesignSystem
import BackbaseObservability
import ClientCommonGen2
import Foundation
import Observation

/// Drives the SwiftUI account details.
///
/// The screen is described by a single observable `state` and is
/// driven by `async` methods, so SwiftUI can call them straight from `.task` and wait for them to finish.
@MainActor
@Observable
final class AccountDetailsViewModel: AccountDetailsViewModeling {

    // MARK: - State

    /// What the screen shows: loading until the first load has finished and while any later load is in
    /// flight, then either the formatted and localised account or the error of the last load.
    private(set) var state: ViewState<AccountDetailsContent> = .loading

    // MARK: - Dependencies

    @ObservationIgnored private let model: AccountDetailsModeling
    @ObservationIgnored private let configuration: AccountsJourney.Configuration
    @ObservationIgnored private let tracker: BackbaseObservability.Tracker?
    @ObservationIgnored private let contentMapper: AccountDetailsContentMapper
    @ObservationIgnored private let errorMapper: AccountDetailsErrorConfigurationMapper

    // MARK: - Private

    @ObservationIgnored private let loadCoordinator = LoadCoordinator()

    // MARK: - Init

    /// - Parameters:
    ///   - model: Provides the account to show.
    ///   - configuration: Provides the strings and icons the account is mapped with.
    ///   - tracker: Receives the analytics events. `nil` disables tracking.
    ///   - contentMapper: Formats and localises the account for the screen. Defaults to a mapper
    ///     using the strings of `configuration`.
    ///   - errorMapper: Builds what the error state shows. Defaults to a mapper using the strings and
    ///     the design of `configuration`.
    init(
        model: AccountDetailsModeling,
        configuration: AccountsJourney.Configuration,
        tracker: BackbaseObservability.Tracker? = nil,
        contentMapper: AccountDetailsContentMapper? = nil,
        errorMapper: AccountDetailsErrorConfigurationMapper? = nil
    ) {
        self.model = model
        self.configuration = configuration
        self.tracker = tracker
        self.contentMapper = contentMapper ?? AccountDetailsContentMapper(strings: configuration.accountDetails.strings)
        self.errorMapper = errorMapper ?? AccountDetailsErrorConfigurationMapper(journeyConfiguration: configuration)
    }

    // MARK: - Methods

    /// To be called every time the screen appears.
    func screenDidAppear() {
        tracker?.publish(event: ScreenViewEvent(.accountDetails))
    }

    /// Loads the account the first time it is called, and does nothing afterwards.
    func loadIfNeeded() async {
        guard loadCoordinator.beginFirstLoad() else { return }
        await load()
    }

    /// Loads the account, whether it has been loaded before or not. Also what the retry button runs.
    func load() async {
        let loadToken = loadCoordinator.beginLoad()
        state = .loading

        let result = await model.fetchAccountDetail()

        // A newer load is in flight, and owns the state.
        guard loadCoordinator.isCurrent(loadToken) else { return }

        switch result {
        case let .success(accountDetailsResponse):
            let details = accountDetailsResponse.toMapUI(configuration: configuration)
            state = .loaded(contentMapper.content(for: details))
        case let .failure(errorResponse):
            // The retry button loads the account again.
            state = .error(errorMapper.stateViewConfiguration(for: .loadingFailure(errorResponse)) { [weak self] in
                Task { await self?.load() }
            })
        }
    }
}
