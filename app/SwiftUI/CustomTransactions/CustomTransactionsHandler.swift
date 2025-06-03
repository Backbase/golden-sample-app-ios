import AccountsJourney
import SwiftUI

enum CustomTransactionsState {}

struct CustomData {
    let graphShown: Bool
}

struct ToggleGraphIntent: TransactionsIntent {}

extension TransactionsState<CustomTransactionsState, CustomData> {    
    var isGraphShown: Bool {
        switch self {
        case .loading(let loadingData):
            return loadingData.stateExtension?.graphShown ?? false
        case .error(let errorData):
            return errorData.stateExtension?.graphShown ?? false
        case .loaded(let loadedData):
            return loadedData.stateExtension?.graphShown ?? false
        case .custom:
            return false // Default value for custom state
        }
    }
}

@MainActor
class ToggleGraphHandler: IntentHandler {

    var intentType: String {
        String(describing: ToggleGraphIntent.self)
    }

    func handle(_ intentContext: IntentContext<any TransactionsIntent, TransactionsState<CustomTransactionsState, CustomData>, TransactionEffect?>) async {
        guard intentContext.intent is ToggleGraphIntent else { return }

        let currentState = intentContext.currentState()
        
        switch currentState {
        case .loading(let loadingData):
            let currentExtension = loadingData.stateExtension ?? CustomData(graphShown: false)
            let newExtension = CustomData(graphShown: !currentExtension.graphShown)
            intentContext.updateState(.loading(TransactionsState.LoadingData(stateExtension: newExtension)))
        case .error(let errorData):
            let currentExtension = errorData.stateExtension ?? CustomData(graphShown: false)
            let newExtension = CustomData(graphShown: !currentExtension.graphShown)
            intentContext.updateState(.error(TransactionsState.ErrorData(errorMessage: errorData.errorMessage, stateExtension: newExtension)))
        case .loaded(let loadedData):
            let currentExtension = loadedData.stateExtension ?? CustomData(graphShown: false)
            let newExtension = CustomData(graphShown: !currentExtension.graphShown)
            intentContext.updateState(.loaded(TransactionsState.LoadedData(transactions: loadedData.transactions, stateExtension: newExtension)))
        case .custom:
            fatalError("Custom state not handled in ToggleGraphHandler")
        }

//        let currentExtension = currentState.stateExtension ?? CustomData(graphShown: false)
//        let newExtension = CustomData(graphShown: !currentExtension.graphShown)
//
//        intentContext.updateState(TransactionsState(
//                isLoading: currentState.isLoading,
//                errorMessage: currentState.errorMessage,
//                transactions: currentState.transactions,
//                stateExtension: newExtension
//            )
//        )
    }
}
