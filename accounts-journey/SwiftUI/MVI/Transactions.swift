import SwiftUI

public enum Transactions {
    
    public enum Intent {
        case viewAppeared
        case refresh
        case newTransaction
    }
    
    @MainActor @Observable
    public class State {
        public var isLoading: Bool = true
        public var errorMessage: String?
        public var data: [TransactionData]?
        
        public init() {}
    }
    
    public class ViewModel: IntentHandler<State, Intent> {
        
        public let client: Client
        
        public init(_ state: State, client: Client) {
            self.client = client
            super.init(state)
        }
        
        public override func handleIntent(_ intent: Intent) async {
            switch intent {
            case .viewAppeared:
                state.isLoading = true
                state.errorMessage = nil
                await loadTransactions()
            case .refresh:
                state.isLoading = true
                state.errorMessage = nil
                state.data = nil
                await loadTransactions()
            case .newTransaction:
                print("Navigate to new transaction")
            }
        }
        
        public func loadTransactions() async {
            let result = await client.fetchTransactions()
            switch result {
            case .success(let transactionsDTOs):
                let transactions = transactionsDTOs.map { TransactionData(from: $0) }
                state.isLoading = false
                state.data = transactions
            case .failure(let error):
                state.isLoading = false
                state.errorMessage = error.localizedDescription
            }
        }
    }
}
