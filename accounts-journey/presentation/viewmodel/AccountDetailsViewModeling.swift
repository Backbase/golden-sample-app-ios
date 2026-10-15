//
//  AccountDetailsViewModeling.swift
//  AccountsJourney
//

import Foundation
import Observation

/// Abstraction the SwiftUI account details screen depends on.
///
/// The screen is described by plain observable properties (`details`, `isLoading`, `error`) and is
/// driven by `async` methods, so SwiftUI can call them straight from `.task` and wait for them to finish.
@MainActor
protocol AccountDetailsViewModeling: AnyObject, Observable {
    // MARK: - State

    /// The loaded account, `nil` while loading and after a failure.
    var details: AccountDetailsUIModel? { get }
    /// `true` until the first load has finished, and while any later load is in flight.
    var isLoading: Bool { get }
    /// Set when the last load failed.
    var error: AccountDetails.Error? { get }

    // MARK: - API

    /// To be called every time the screen appears.
    func screenDidAppear()
    /// Loads the account the first time it is called, and does nothing afterwards.
    func loadIfNeeded() async
    /// Loads the account, whether it has been loaded before or not. Also what the retry button runs.
    func load() async
}
