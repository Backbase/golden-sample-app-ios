import AccountsJourney
import SwiftUI

struct CustomData {
    let graphShown: Bool
}

enum CustomIntent {
    case defaultIntent(TransactionsIntent)
    case toggleGraph
}

@MainActor
open class CustomTransactionsViewModel: ObservableObject {
    @Published var state: TransactionsState<CustomData>

    private lazy var intentHandler: TransactionsIntentHandler<CustomData> = {
        TransactionsIntentHandler(
            configuration: TransactionsConfiguration(isActive: true),
            setState: { [weak self] newValue in
            self?.state = TransactionsState(isLoading: newValue.isLoading,
                                            errorMessage: newValue.errorMessage,
                                            transactions: newValue.transactions,
                                            stateExtension: self?.state.stateExtension)
        })
    }()

    init(initialState: TransactionsState<CustomData>) {
        self.state = initialState
    }

    func handleIntent(_ intent: CustomIntent) async {
        switch intent {
        case .defaultIntent(let wrappedIntent):
            await intentHandler.handleIntent(wrappedIntent)
        case .toggleGraph:
            self.state = TransactionsState(isLoading: state.isLoading,
                                           errorMessage: state.errorMessage,
                                           transactions: state.transactions,
                                           stateExtension: CustomData(graphShown: !state.stateExtension!.graphShown))
        }
    }
}
