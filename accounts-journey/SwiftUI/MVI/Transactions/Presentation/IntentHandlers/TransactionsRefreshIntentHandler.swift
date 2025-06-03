import Foundation
import Combine

@MainActor
public class TransactionsRefreshIntentHandler<S>: IntentHandler {
    public typealias Intent = any TransactionsIntent
    public typealias State = TransactionsState<S>
    public typealias Effect = TransactionEffect

    let client: any TransactionsClient

    public var intentType: String { String(describing: RefreshIntent.self) }

    public init(client: TransactionsClient) {
        self.client = client
    }

    public func handle(_ intentContext: IntentContext<any TransactionsIntent, TransactionsState<S>, TransactionEffect?>) async {
        guard intentContext.intent is RefreshIntent else { return }

        intentContext.updateState(
            TransactionsState(isLoading: true, errorMessage: nil, transactions: nil, stateExtension: intentContext.currentState().stateExtension)
        )
        await loadTransactions(intentContext)
    }

    private func loadTransactions(_ intentContext: IntentContext<any TransactionsIntent, TransactionsState<S>, TransactionEffect?>) async {
        let result = await client.fetchTransactions()
        switch result {
        case .success(let transactionsDTOs):
            let transactions = transactionsDTOs.map { TransactionData(from: $0) }
            intentContext.updateState(
                TransactionsState(isLoading: false, errorMessage: nil, transactions: transactions, stateExtension: intentContext.currentState().stateExtension)
            )
        case .failure(let error):
            intentContext.updateState(
                TransactionsState(isLoading: false, errorMessage: error.localizedDescription, transactions: nil, stateExtension: intentContext.currentState().stateExtension)
            )
        }
    }
}
