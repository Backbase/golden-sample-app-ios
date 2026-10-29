//
//  LoadCoordinator.swift
//  AccountsJourney
//

import Foundation

/// Coordinates concurrent and sequential async loads so that:
/// - Only the latest result wins when multiple loads overlap (prevents race conditions).
/// - A "load if needed" call is never repeated once the first load has started.
///
/// Usage in a view model:
/// ```swift
/// @ObservationIgnored private let loadCoordinator = LoadCoordinator()
///
/// func loadIfNeeded() async {
///     guard loadCoordinator.beginFirstLoad() else { return }
///     await load()
/// }
///
/// func load() async {
///     let token = loadCoordinator.beginLoad()
///     state = .loading
///     let result = await model.fetch()
///     guard loadCoordinator.isCurrent(token) else { return }
///     // apply result …
/// }
/// ```
@MainActor
final class LoadCoordinator {

    // MARK: - Private

    private var hasLoaded = false
    private var latestLoadID = 0

    // MARK: - API

    /// Marks the first load as started and returns `true` exactly once; `false` on every
    /// subsequent call. Thread-safe because the coordinator is `@MainActor`.
    func beginFirstLoad() -> Bool {
        guard !hasLoaded else { return false }
        hasLoaded = true
        return true
    }

    /// Registers a new load and returns an opaque token. Pass the token to ``isCurrent(_:)``
    /// after any `await` point to confirm this load still owns the state.
    func beginLoad() -> Int {
        latestLoadID += 1
        return latestLoadID
    }

    /// Returns `true` when `token` belongs to the most recently started load — i.e. no newer
    /// load has started since ``beginLoad()`` returned this token.
    func isCurrent(_ token: Int) -> Bool {
        token == latestLoadID
    }
}
