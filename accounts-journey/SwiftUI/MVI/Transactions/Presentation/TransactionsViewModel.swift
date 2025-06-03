import SwiftUI

@MainActor
open class TransactionsViewModel<T, DataType>: ViewModel<any TransactionsIntent, TransactionsState<T, DataType>, TransactionEffect> {

    public init(
        initialState: TransactionsState<T, DataType> = .initial,
        viewAppearedHandler: (any IntentHandler<any TransactionsIntent, TransactionsState<T, DataType>, TransactionEffect>)? = nil,
        refreshHandler: (any IntentHandler<any TransactionsIntent, TransactionsState<T, DataType>, TransactionEffect>)? = nil,
        newTransactionHandler: (any IntentHandler<any TransactionsIntent, TransactionsState<T, DataType>, TransactionEffect>)? = nil,
        additionalHandlers: [any IntentHandler<any TransactionsIntent, TransactionsState<T, DataType>, TransactionEffect>] = []
    ) {
        let defaultHandlers: [any IntentHandler<any TransactionsIntent, TransactionsState<T, DataType>, TransactionEffect>] = [
            viewAppearedHandler ?? TransactionsViewAppearedIntentHandler<T, DataType>(client: DefaultTransactionsClient()),
            refreshHandler ?? TransactionsRefreshIntentHandler<T, DataType>(client: DefaultTransactionsClient()),
            newTransactionHandler ?? TransactionsNewTransactionHandler()
        ]

        super.init(
            initialState: initialState,
            handlers: defaultHandlers + additionalHandlers
        )
    }
}
