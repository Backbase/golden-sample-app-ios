import AccountsJourney
import SwiftUI

enum CustomIntent {
    case transactions(Transactions.Intent)
    case toggleGraph
}

@Observable
class CustomState {
    var graphShown: Bool = false
    
    // we could just not have this property and the Transactions.ViewModel
    // is inited with its own state and you access it through the subviewModel
    // instead of this state object, so like:
    //
    // viewModel.transactions.state.something
    //           ^^^^^^^^^^^^-- Transactions.ViewModel
    //
    // instead of (how it is now)
    //
    // viewModel.state.transactions.something
    //                 ^^^^^^^^^^^^-- sub state of CustomState
    //
    // The former makes it slightly less code in the CustomState
    // The latter makes the CustomState a one stop shop for all state
    // Overall no difference, just different ways to access state
    let transactions = Transactions.State()
    
    init() {}
}

@MainActor
class CustomViewModel: IntentHandler<CustomState, CustomIntent> {
    
    var transactions: Transactions.ViewModel
    
    init(_ state: CustomState, client: Client) {
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
