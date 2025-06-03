import AccountsJourney
import SwiftUI

struct CustomData {
    let graphShown: Bool
}

struct ToggleGraphIntent: TransactionsIntent {}

@MainActor
class ToggleGraphHandler: IntentHandler {

    var intentType: String {
        String(describing: ToggleGraphIntent.self)
    }

    func handle(_ intentContext: IntentContext<any TransactionsIntent, TransactionsState<CustomData>, TransactionEffect?>) async {
        guard intentContext.intent is ToggleGraphIntent else { return }

        let currentState = intentContext.currentState()

        let currentExtension = currentState.stateExtension ?? CustomData(graphShown: false)
        let newExtension = CustomData(graphShown: !currentExtension.graphShown)

        intentContext.updateState(TransactionsState(
                isLoading: currentState.isLoading,
                errorMessage: currentState.errorMessage,
                transactions: currentState.transactions,
                stateExtension: newExtension
            )
        )
    }
}
