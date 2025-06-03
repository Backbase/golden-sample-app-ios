import SwiftUI

@MainActor
open class TransactionsViewModel<T>: ViewModel<any TransactionsIntent, TransactionsState<T>, TransactionEffect> {

    public init(
        initialState: TransactionsState<T> = .initial,
        viewAppearedHandler: (any IntentHandler<any TransactionsIntent, TransactionsState<T>, TransactionEffect>)? = nil,
        refreshHandler: (any IntentHandler<any TransactionsIntent, TransactionsState<T>, TransactionEffect>)? = nil,
        newTransactionHandler: (any IntentHandler<any TransactionsIntent, TransactionsState<T>, TransactionEffect>)? = nil,
        additionalHandlers: [any IntentHandler<any TransactionsIntent, TransactionsState<T>, TransactionEffect>] = []
    ) {
        let defaultHandlers: [any IntentHandler<any TransactionsIntent, TransactionsState<T>, TransactionEffect>] = [
            viewAppearedHandler ?? TransactionsViewAppearedIntentHandler<T>(client: DefaultTransactionsClient()),
            refreshHandler ?? TransactionsRefreshIntentHandler<T>(client: DefaultTransactionsClient()),
            newTransactionHandler ?? TransactionsNewTransactionHandler()
        ]

        super.init(
            initialState: initialState,
            handlers: defaultHandlers + additionalHandlers
        )
    }
}
