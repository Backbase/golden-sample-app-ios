import Combine

/// Represent a side effect that can produce actions over time
/// A type that represents an effect, which can emit actions over time.
struct Effect<Action> {
    /// The publisher that will emit actions.
    let publisher: AnyPublisher<Action, Never>

    /// Creates an effect that doesn't emit any actions.
    /// - Returns: An effect with an empty publisher.
    static var none: Effect {
        Effect(publisher: Empty().eraseToAnyPublisher())
    }

    /// Creates an effect from an asynchronous operation.
    /// - Parameter operation: An async function that returns an `Action`.
    /// - Returns: An effect that emits the result of the async operation.
    static func task(_ operation: @escaping () async throws -> Action) -> Effect {
        Effect(publisher: Future { promise in
            /// Not Swift 6 ready: We strongly capture the action which is not sendable that might run concurrently with other work.
            /// Task-isolated value of type '() async -> ()' passed as a strongly transferred parameter; later accesses could race
            Task {
                do {
                    let action = try await operation()
                    promise(.success(action))
                } catch {
                    // Error is ignored; no action is emitted in case of failure.
                }
            }
        }.eraseToAnyPublisher())
    }

    /// Creates an effect that immediately emits a single action.
    /// - Parameter action: The action to emit.
    /// - Returns: An effect that emits the given action once.
    static func just(_ action: Action) -> Effect {
        Effect(publisher: Just(action).eraseToAnyPublisher())
    }
}
