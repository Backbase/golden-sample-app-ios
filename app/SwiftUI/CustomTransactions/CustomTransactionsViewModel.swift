import AccountsJourney
import SwiftUI

struct CustomData {
    let graphShown: Bool
}

struct ToggleGraphIntent: TransactionsIntent {}

@MainActor
class ToggleGraphHandler: IntentHandler {
    typealias Intent = any TransactionsIntent
    typealias State = TransactionsState<CustomData>

    var intentType: String {
        String(describing: ToggleGraphIntent.self)
    }

    func handle(_ intentContext: IntentContext<any TransactionsIntent, TransactionsState<CustomData>>) async {
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

@MainActor
class CustomTransactionsViewModel: TransactionsViewModel<CustomData> {

    init() {
        let initialState = TransactionsState<CustomData>(
            isLoading: false,
            errorMessage: nil,
            transactions: nil,
            stateExtension: CustomData(graphShown: false)
        )

        super.init(
            initialState: initialState,
            // You can override default handlers if needed
            viewAppearedHandler: TransactionsViewAppearedIntentHandler<CustomData>(client: DefaultTransactionsClient()),
            refreshHandler: TransactionsRefreshIntentHandler<CustomData>(client: DefaultTransactionsClient()),
            // Add your custom handlers
            additionalHandlers: [
                ToggleGraphHandler()
            ]
        )
    }
}
