import SwiftUI

@MainActor
public class TransactionsViewModel<T>: ObservableObject {
    @Published var state: TransactionsState<T>
    private let configuration: TransactionsConfiguration

    private lazy var intentHandler: TransactionsIntentHandler<T> = {
        TransactionsIntentHandler(
            configuration: configuration,
            setState: { [weak self] newValue in
                self?.state = newValue
            }
        )
    }()

    init(
        configuration: TransactionsConfiguration,
        initialState: TransactionsState<T> = TransactionsState<T>.initial
    ) {
        self.configuration = configuration
        self.state = initialState
    }

    func handleIntent(_ intent: TransactionsIntent) async {
        await intentHandler.handleIntent(intent)
    }
}
