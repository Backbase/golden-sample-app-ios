import Foundation
import Combine

@MainActor
@Observable
class ViewModel<R: Reducer> {
    /// Holds the current state of the view.
    var state: R.ViewState

    /// Stores cancellable subscriptions to manage memory and prevent retain cycles.
    private var cancellables: Set<AnyCancellable> = []

    /// The reducer responsible for handling state transitions based on events.
    private let reducer: R

    /// Initializes the ViewModel with an initial state and a reducer.
    /// - Parameters:
    ///   - initialState: The starting state for the view.
    ///   - reducer: The reducer that defines how state changes in response to events.
    init(initialState: R.ViewState, reducer: R) {
        self.state = initialState
        self.reducer = reducer
    }

    /// Sends an event to the reducer, triggering a state transition and handling any side effects.
    /// - Parameter event: The event to be processed by the reducer.
    func send(_ event: R.ViewEvent) {
        // Obtain the effect produced by the reducer when processing the event.
        let effect = reducer.reduce(&state, event: event)

        // Handle the effect's emitted events and recursively send them back into the ViewModel.
        effect.publisher
            .sink { [weak self] event in
                self?.send(event) // Ensures that emitted events are processed in a loop.
            }
            .store(in: &cancellables) // Store subscription to manage its lifecycle.
    }
}

