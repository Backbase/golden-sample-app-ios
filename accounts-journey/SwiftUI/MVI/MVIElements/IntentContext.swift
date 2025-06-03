import Foundation

public struct IntentContext<Intent, State, Effect> {
    public let intent: Intent
    public let currentState: () -> State
    public let updateState: (State) -> Void
    public let emitEffect: (Effect) -> Void
}
