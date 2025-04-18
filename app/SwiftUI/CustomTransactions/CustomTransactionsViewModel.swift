import AccountsJourney
import SwiftUI

@Observable
class CustomData {
    var graphShown: Bool
    let transactions = Transactions.State()
    
    init(graphShown: Bool) {
        self.graphShown = graphShown
    }
}

enum CustomIntent {
    case transactions(Transactions.Intent)
    case toggleGraph
}

@MainActor
class CustomTransactionsViewModel: Interactor<CustomData, CustomIntent> {
    
    var transactions: Transactions.ViewModel
    
    override init(_ state: CustomData) {
        transactions = Transactions.ViewModel(state.transactions)
        super.init(state)
    }

    override func handleIntent(_ intent: CustomIntent) async {
        switch intent {
        case .toggleGraph:
            state.graphShown.toggle()
        case .transactions(let intent):
            await transactions.handleIntent(intent)
        }
    }
}
