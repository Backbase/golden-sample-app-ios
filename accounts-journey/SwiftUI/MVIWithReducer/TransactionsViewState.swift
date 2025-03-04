import Foundation

struct TransactionsViewState: Equatable {
    let isLoading: Bool
    let errorMessage: String?
    let transactions: [Transaction]?

    static var initial: TransactionsViewState {
        TransactionsViewState(isLoading: true, errorMessage: nil, transactions: nil)
    }
}
