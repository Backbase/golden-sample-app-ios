import Foundation
import Combine

@MainActor
public class TransactionsNewTransactionHandler<S>: IntentHandler {
    public typealias Intent = any TransactionsIntent
    public typealias State = TransactionsState<S>
    public typealias Effect = TransactionEffect

    public var intentType: String { String(describing: NewTransactionIntent.self) }

    public init() {}

    public func handle(_ intentContext: IntentContext<any TransactionsIntent, TransactionsState<S>, TransactionEffect?>) async {
        guard intentContext.intent is NewTransactionIntent else { return }

        intentContext.emitEffect(.navigateToNewTransaction)
    }
}
