import Foundation

@MainActor
open class ViewModel<Intent, State>: ObservableObject {
    @Published public var state: State

    private var handlers: [String: any IntentHandler<Intent, State>] = [:]

    init(initialState: State, handlers: [any IntentHandler<Intent, State>]) {
        self.state = initialState

        for handler in handlers {
            let typeKey = String(describing: handler.intentType)
            self.handlers[typeKey] = handler
        }
    }

    public func handle(_ intent: Intent) async {
        let intentTypeName = String(describing: type(of: intent as Any))

        guard let handler = handlers[intentTypeName] else {
            return
        }

        let context = IntentContext(
            intent: intent,
            currentState: { [weak self] in
                self?.state ?? self!.state
            },
            updateState: { [weak self] newState in
                self?.state = newState
            }
        )

        await handler.handle(context)
    }
}
