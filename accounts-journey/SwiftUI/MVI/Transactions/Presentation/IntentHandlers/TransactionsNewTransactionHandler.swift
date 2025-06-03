import Foundation
import Combine

@MainActor
public class TransactionsNewTransactionHandler<S, DataType>: IntentHandler {

    public var intentType: String { String(describing: NewTransactionIntent.self) }

    public init() {}

    public func handle(_ intentContext: IntentContext<any TransactionsIntent, TransactionsState<S, DataType>, TransactionEffect?>) async {
        guard intentContext.intent is NewTransactionIntent else { return }

        intentContext.emitEffect(.navigateToNewTransaction)
    }
}
