import SwiftUI

public enum Transactions { }

extension Transactions {
    
    open class ViewModel: Interactor<State, Intent> {
        
        public override init(_ state: State) {
            super.init(state)
        }
        
        public let client = TransactionsClient()
        
        open override func handleIntent(_ intent: Intent) async {
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
        
        open func loadTransactions() async {
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

@MainActor
open class Interactor<State: Observable, Intent>: IntentHandlerProtocol {
    public let state: State
    
    public init(_ initialState: State) {
        self.state = initialState
    }
    
    public func sendIntent(_ intent: Intent) {
        Task {
            await handleIntent(intent)
        }
    }
    
    open func handleIntent(_ intent: Intent) async {
        
    }
}

public protocol IntentHandlerProtocol {
    associatedtype State
    associatedtype Intent
    func handleIntent(_ intent: Intent) async
}
