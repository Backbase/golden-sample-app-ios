import SwiftUI

@MainActor
public class TransactionsViewModel<T, DataType>: ViewModel<any TransactionsIntent, TransactionsState<T, DataType>, TransactionEffect> {

    public typealias TransactionsIntentHandler = any IntentHandler<any TransactionsIntent, TransactionsState<T, DataType>, TransactionEffect>
    
    // Builder class for TransactionsViewModel
    @MainActor
    public class Builder {
        private var handlerRegistry: [String: TransactionsIntentHandler] = [:]
        private(set) var initialState: TransactionsState<T, DataType> = .initial
        var handlers: [TransactionsIntentHandler] {
            handlerRegistry.values.map { $0 }
        }
        
        public init() {
            let defaultHandlers: [TransactionsIntentHandler] = [
                TransactionsViewAppearedIntentHandler<T, DataType>(client: DefaultTransactionsClient()),
                TransactionsRefreshIntentHandler<T, DataType>(client: DefaultTransactionsClient()),
                TransactionsNewTransactionHandler()
            ]
            
            for handler in defaultHandlers {
                let typeKey = String(describing: handler.intentType)
                self.handlerRegistry[typeKey] = handler
            }
        }
        
        // Initialize with custom initial state
        @discardableResult
        public func with(initialState: TransactionsState<T, DataType>) -> Self {
            self.initialState = initialState
            return self
        }
        
        // Set custom view appeared handler
        @discardableResult
        public func with(viewAppearedHandler: TransactionsIntentHandler) -> Self {
            let typeKey = String(describing: viewAppearedHandler.intentType)
            self.handlerRegistry[typeKey] = viewAppearedHandler
            return self
        }
        
        // Set custom refresh handler
        @discardableResult
        public func with(refreshHandler: TransactionsIntentHandler) -> Self {
            let typeKey = String(describing: refreshHandler.intentType)
            self.handlerRegistry[typeKey] = refreshHandler
            return self
        }
        
        // Set custom new transaction handler
        @discardableResult
        public func with(newTransactionHandler: TransactionsIntentHandler) -> Self {
            let typeKey = String(describing: newTransactionHandler.intentType)
            self.handlerRegistry[typeKey] = newTransactionHandler
            return self
        }
        
        // Add additional handlers
        @discardableResult
        public func with(additionalHandlers: [TransactionsIntentHandler]) -> Self {
            for handler in additionalHandlers {
                let typeKey = String(describing: handler.intentType)
                self.handlerRegistry[typeKey] = handler
            }
            return self
        }
        
        // Build and return the ViewModel
        public func build() -> TransactionsViewModel<T, DataType> {
            return TransactionsViewModel(
                initialState: initialState,
                handlers: handlers
            )
        }
    }
}
