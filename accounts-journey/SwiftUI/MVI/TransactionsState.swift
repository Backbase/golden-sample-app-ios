import SwiftUI
import Foundation

public struct TransactionsState<T> {
    public let isLoading: Bool
    public let errorMessage: String?
    public let transactions: [TransactionData]?

    public let stateExtension: T?

    public init(isLoading: Bool, errorMessage: String?, transactions: [TransactionData]?, stateExtension: T?) {
        self.isLoading = isLoading
        self.errorMessage = errorMessage
        self.transactions = transactions
        self.stateExtension = stateExtension
    }

    static var initial: TransactionsState<T> {
        TransactionsState(isLoading: true, errorMessage: nil, transactions: nil, stateExtension: nil)
    }
}
