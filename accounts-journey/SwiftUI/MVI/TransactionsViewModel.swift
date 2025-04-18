import SwiftUI

public enum Transactions { }

extension Transactions {
    
    @MainActor
    open class ViewModel<T>: ObservableObject {
        let state: Transactions.State<T>
        
        private lazy var intentHandler: TransactionsIntentHandler<T> = TransactionsIntentHandler()
        
        init(initialState: Transactions.State<T> = Transactions.State<T>()) {
            self.state = initialState
        }
        
        func handleIntent(_ intent: TransactionsIntent) {
            Task {
                await intentHandler.handleIntent(intent, state)
            }
        }
    }
}

//@MainActor
//open class ViewModel<S, I>: ObservableObject {
//    
//    @Published var state: S
//    
//    private lazy var intentHandler: TransactionsIntentHandler<T> = TransactionsIntentHandler() { [unowned self] newValue in
//        self.state = newValue
//    }
//    
//    init(initialState: TransactionsState<T> = TransactionsState<T>()) {
//        self.state = initialState
//    }
//    
//    func handleIntent(_ intent: TransactionsIntent) {
//        Task {
//            await intentHandler.handleIntent(intent, state)
//        }
//    }
//}



