import Foundation
import Combine

@MainActor
open class ViewModel<Intent, State, Effect>: ObservableObject {
    @Published public var state: State
    public let effectSubject = PassthroughSubject<Effect, Never>()

    private var handlers: [String: any IntentHandler<Intent, State, Effect>] = [:]

    init(initialState: State, handlers: [any IntentHandler<Intent, State, Effect>]) {
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

        let context = IntentContext<Intent, State, Effect?>(
            intent: intent,
            currentState: { [weak self] in
                self?.state ?? self!.state
            },
            updateState: { [weak self] newState in
                self?.state = newState
            },
            emitEffect: { [weak self] newEffect in
                if let newEffect = newEffect {
                    self?.effectSubject.send(newEffect)
                }
            }
        )

        await handler.handle(context)
    }
}
