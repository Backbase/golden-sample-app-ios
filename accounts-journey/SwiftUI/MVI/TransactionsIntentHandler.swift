import Foundation
import Combine

extension Transactions {
    
    @MainActor
    public class IntentHandler<E> {
        
        private let client = TransactionsClient()
        
        private let state: Transactions.State<E>
        
        public init(_ state: Transactions.State<E>) {
            self.state = state
        }
        
        public func handleIntent(_ intent: TransactionsIntent) async {
            switch intent {
            case .viewAppeared:
                state.isLoading.set(true)
                state.errorMessage.set(nil)
                await loadTransactions()
            case .refresh:
                state.isLoading.set(true)
                state.errorMessage.set(nil)
                state.transactions.set(nil)
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
                state.isLoading.set(false)
                state.transactions.set(transactions)
            case .failure(let error):
                state.isLoading.set(false)
                state.errorMessage.set(error.localizedDescription)
            }
        }
    }
}
