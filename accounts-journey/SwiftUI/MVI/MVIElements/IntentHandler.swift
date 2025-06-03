import Foundation

public protocol IntentHandler <Intent, State, Effect> {
    associatedtype Intent
    associatedtype State
    associatedtype Effect

    nonisolated var intentType: String { get }

    func handle(_ intentContext: IntentContext<Intent, State, Effect?>) async
}
