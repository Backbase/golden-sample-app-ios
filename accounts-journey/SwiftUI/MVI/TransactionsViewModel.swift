import SwiftUI

@MainActor
open class TransactionsViewModel<T>: ObservableObject {
    @Published var state: TransactionsState<T>

    private lazy var intentHandler: TransactionsIntentHandler<T> = {
        TransactionsIntentHandler(setState: { [weak self] newValue in
            self?.state = newValue
        })
    }()

    init(initialState: TransactionsState<T> = TransactionsState<T>.initial) {
        self.state = initialState
    }

    func handleIntent(_ intent: TransactionsIntent) async {
        await intentHandler.handleIntent(intent)
    }
}
