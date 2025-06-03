import Foundation
import Combine

@MainActor
public class TransactionsRefreshIntentHandler<S, DataType>: IntentHandler {

    let client: any TransactionsClient

    public var intentType: String { String(describing: RefreshIntent.self) }

    public init(client: TransactionsClient) {
        self.client = client
    }

    public func handle(_ intentContext: IntentContext<any TransactionsIntent, TransactionsState<S, DataType>, TransactionEffect?>) async {
        guard intentContext.intent is RefreshIntent else { return }

        intentContext.updateState(
            .loading(TransactionsState.LoadingData(stateExtension: intentContext.currentState().stateExtension))
        )
        await loadTransactions(intentContext)
    }

    private func loadTransactions(_ intentContext: IntentContext<any TransactionsIntent, TransactionsState<S, DataType>, TransactionEffect?>) async {
        let result = await client.fetchTransactions()
        switch result {
        case .success(let transactionsDTOs):
            let transactions = transactionsDTOs.map { TransactionData(from: $0) }
            intentContext.updateState(
                .loaded(TransactionsState.LoadedData(transactions: transactions, stateExtension: intentContext.currentState().stateExtension))
            )
        case .failure(let error):
            intentContext.updateState(
                .error(TransactionsState.ErrorData(errorMessage: error.localizedDescription, stateExtension: intentContext.currentState().stateExtension))
            )
        }
    }
}
