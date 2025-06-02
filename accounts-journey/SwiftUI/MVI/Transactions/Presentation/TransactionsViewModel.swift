import SwiftUI

@MainActor
open class TransactionsViewModel<T>: ViewModel<any TransactionsIntent, TransactionsState<T>> {

    public init(
        initialState: TransactionsState<T> = .initial,
        viewAppearedHandler: (any IntentHandler<any TransactionsIntent, TransactionsState<T>>)? = nil,
        refreshHandler: (any IntentHandler<any TransactionsIntent, TransactionsState<T>>)? = nil,
        additionalHandlers: [any IntentHandler<any TransactionsIntent, TransactionsState<T>>] = []
    ) {
        let defaultHandlers: [any IntentHandler<any TransactionsIntent, TransactionsState<T>>] = [
            viewAppearedHandler ?? TransactionsViewAppearedIntentHandler<T>(client: DefaultTransactionsClient()),
            refreshHandler ?? TransactionsRefreshIntentHandler<T>(client: DefaultTransactionsClient())
        ]

        super.init(
            initialState: initialState,
            handlers: defaultHandlers + additionalHandlers
        )
    }
}
