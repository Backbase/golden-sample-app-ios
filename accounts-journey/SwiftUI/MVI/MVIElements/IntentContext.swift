import Foundation

public struct IntentContext<Intent, State> {
    public let intent: Intent
    public let currentState: () -> State
    public let updateState: (State) -> Void
}
