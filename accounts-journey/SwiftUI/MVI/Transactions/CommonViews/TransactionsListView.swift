import SwiftUI

public struct TransactionsListView: View {

    let transactions: [TransactionData]
    let onRefresh: () -> Void

    public init(transactions: [TransactionData], onRefresh: @escaping () -> Void) {
        self.transactions = transactions
        self.onRefresh = onRefresh
    }

    public var body: some View {
        List(transactions) { transaction in
            TransactionRowView(transaction: transaction)
        }
        .listStyle(.plain)
        .refreshable {
            onRefresh()
        }
    }
}

#Preview {
    let sample = TransactionData(id: "0",
                              date: "1 January 2025, 10:00",
                              name: "Apple services",
                              amount: "€ -19.0",
                              iconName: "arrow.down.right.circle.fill")
    TransactionsListView(transactions: Array(repeating: sample, count: 30), onRefresh: {})
}
