import SwiftUI
import Foundation

struct TransactionsState<T> {
    let isLoading: Bool
    let errorMessage: String?
    let transactions: [Transaction]?

    let stateExtension: T?

    static var initial: TransactionsState<T> {
        TransactionsState(isLoading: true, errorMessage: nil, transactions: nil, stateExtension: nil)
    }
}
