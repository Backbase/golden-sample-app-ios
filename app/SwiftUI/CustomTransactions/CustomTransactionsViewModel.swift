import AccountsJourney
import SwiftUI

struct CustomData {
    let graphShown: Bool

    init(graphShown: Bool) {
        self.graphShown = graphShown
    }
}

enum CustomIntent {
    case defaultIntent(TransactionsIntent)
    case toggleGraph
}

@MainActor
open class CustomTransactionsViewModel: ObservableObject {
    @Published var state: TransactionsState<CustomData>

    private lazy var intentHandler: TransactionsIntentHandler<CustomData> = {
        TransactionsIntentHandler(setState: { [weak self] newValue in
            self?.state = newValue
        })
    }()

    init(initialState: TransactionsState<CustomData>) {
        self.state = initialState
    }

    func handleIntent(_ intent: CustomIntent) async {
        switch intent {
        case .defaultIntent(let wrappedIntent):
            await intentHandler.handleIntent(wrappedIntent, state)
        case .toggleGraph:
            self.state.stateExtension = CustomData(graphShown: !state.stateExtension!.graphShown)
        }
    }
}
