import Foundation

public protocol IntentHandler <Intent, State> {
    associatedtype Intent
    associatedtype State

    nonisolated var intentType: String { get }

    func handle(_ intentContext: IntentContext<Intent, State>) async
}
