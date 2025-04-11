import Foundation
import Combine

@MainActor
final class TransactionsIntentHandler<T> {

    private let client = TransactionsClient()

    private let setState: (TransactionsState<T>) -> Void

    init(setState: @escaping (TransactionsState<T>) -> Void) {
        self.setState = setState
    }

    func handleIntent(_ intent: TransactionsIntent) async {
        switch intent {
        case .viewAppeared:
            setState(TransactionsState(isLoading: true, errorMessage: nil, transactions: nil, stateExtension: nil))
            await loadTransactions()
        case .refresh:
            setState(TransactionsState(isLoading: true, errorMessage: nil, transactions: nil, stateExtension: nil))
            await loadTransactions()
        case .newTransaction:
            print("Navigate to new transaction")
        }
    }

    func loadTransactions() async {
        let result = await client.fetchTransactions()
        switch result {
        case .success(let transactionsDTOs):
            let transactions = transactionsDTOs.map { Transaction(from: $0) }
            setState(TransactionsState(isLoading: false, errorMessage: nil, transactions: transactions, stateExtension: nil))
        case .failure(let error):
            setState(TransactionsState(isLoading: false, errorMessage: error.localizedDescription, transactions: nil, stateExtension: nil))
        }
    }
}
