import AccountsJourney
import SwiftUI

@Observable
class CustomData {
    var graphShown: Bool = false
    let transactions = Transactions.State()
    
    init() {}
}

enum CustomIntent {
    case transactions(Transactions.Intent)
    case toggleGraph
}

@MainActor
class CustomViewModel: IntentHandler<CustomData, CustomIntent> {
    
    var transactions: Transactions.ViewModel
    
    init(_ state: CustomData, client: Client) {
        transactions = Transactions.ViewModel(state.transactions, client: client)
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
