import Foundation
import Combine

@MainActor
public class TransactionsIntentHandler<T> {

    private let client = TransactionsClient()
    private let configuration: TransactionsConfiguration

    private let setState: (TransactionsState<T>) -> Void

    public init(configuration: TransactionsConfiguration, setState: @escaping (TransactionsState<T>) -> Void) {
        self.configuration = configuration
        self.setState = setState
    }

    public func handleIntent(_ intent: TransactionsIntent) async {
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

    private func loadTransactions() async {
        let result = await client.fetchTransactions()
        switch result {
        case .success(let transactionsDTOs):
            let transactions = transactionsDTOs.map { TransactionData(from: $0) }
            setState(TransactionsState(isLoading: false, errorMessage: nil, transactions: transactions, stateExtension: nil))
        case .failure(let error):
            setState(TransactionsState(isLoading: false, errorMessage: error.localizedDescription, transactions: nil, stateExtension: nil))
        }
    }
}
