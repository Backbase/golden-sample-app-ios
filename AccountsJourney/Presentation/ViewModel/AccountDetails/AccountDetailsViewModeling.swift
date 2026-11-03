//
//  AccountDetailsViewModeling.swift
//  AccountsJourney
//

import Foundation
import Observation

/// Abstraction the SwiftUI account details screen depends on.
///
/// The screen is described by a single observable `state` and is
/// driven by `async` methods, so SwiftUI can call them straight from `.task` and wait for them to finish.
@MainActor
protocol AccountDetailsViewModeling: AnyObject, Observable {
    // MARK: - State

    /// What the screen shows: loading until the first load has finished and while any later load is in
    /// flight, then either the formatted and localised account or the error of the last load.
    var state: ViewState<AccountDetailsContent> { get }

    // MARK: - API

    /// To be called every time the screen appears.
    func screenDidAppear()
    /// Loads the account the first time it is called, and does nothing afterwards.
    func loadIfNeeded() async
    /// Loads the account, whether it has been loaded before or not. Also what the retry button runs.
    func load() async
}
