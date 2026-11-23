//
//  ViewState.swift
//  AccountsJourney
//

import BackbaseDesignSystem
import Foundation

/// What a screen that loads a single piece of data shows. Exactly one case holds at a time, so
/// "loading while failed" and the like cannot be represented.
enum ViewState<DataType> {
    /// The data is being loaded. Also the state before the first load has started.
    case loading
    /// The data has been loaded.
    case loaded(DataType)
    /// The load failed. Carries what the state view shows, including its actions such as retry.
    case error(StateViewConfiguration)

    // MARK: - Getters

    var isLoading: Bool {
        if case .loading = self { return true }
        return false
    }

    /// The loaded data, `nil` in any other state.
    var data: DataType? {
        if case let .loaded(data) = self { return data }
        return nil
    }

    /// What the error state shows, `nil` in any other state.
    var errorConfiguration: StateViewConfiguration? {
        if case let .error(configuration) = self { return configuration }
        return nil
    }
}
