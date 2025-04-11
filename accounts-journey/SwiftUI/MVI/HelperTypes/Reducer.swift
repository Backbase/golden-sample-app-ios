import Foundation

/// A protocol defining a reducer that transforms state based on an action.
protocol Reducer<ViewState, ViewEvent> {
    /// The type representing the state of the system.
    associatedtype ViewState

    /// The type representing possible actions that can be performed.
    associatedtype ViewEvent

    /// Applies an action to the current state and returns an effect.
    /// - Parameters:
    ///   - state: The current state, which may be modified.
    ///   - event: The event that might change the state.
    /// - Returns: An effect that may produce additional events.
    func reduce(_ state: inout ViewState, event: ViewEvent) -> Effect<ViewEvent>
}

