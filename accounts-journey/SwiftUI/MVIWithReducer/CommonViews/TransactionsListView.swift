import SwiftUI

struct TransactionsListView: View {

    let transactions: [Transaction]

    var body: some View {
        List(transactions) { transaction in
            TransactionRowView(transaction: transaction)
        }
        .listStyle(.plain)
    }
}

#Preview {
    let sample = Transaction(id: "0",
                              date: "1 January 2025, 10:00",
                              name: "Apple services",
                              amount: "€ -19.0",
                              iconName: "arrow.down.right.circle.fill")
    TransactionsListView(transactions: Array(repeating: sample, count: 30))
}
