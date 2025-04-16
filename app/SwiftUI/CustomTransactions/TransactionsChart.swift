import SwiftUI
import Charts
import AccountsJourney

struct TransactionsChartView: View {
    let transactions = [TransactionData(id: "1", date: "2025-04-15", name: "Groceries", amount: "75.40", iconName: "cart"),
                        TransactionData(id: "2", date: "2025-04-14", name: "Coffee", amount: "4.50", iconName: "cup"),
                        TransactionData(id: "3", date: "2025-04-13", name: "Gas", amount: "45.00", iconName: "fuelpump"),
                        TransactionData(id: "4", date: "2025-04-12", name: "Dinner", amount: "85.25", iconName: "fork.knife"),
                        TransactionData(id: "5", date: "2025-04-11", name: "Shopping", amount: "120.00", iconName: "bag")]

    var body: some View {
        Chart {
            ForEach(transactions) { transaction in
                if let amount = Double(transaction.amount) {
                    BarMark(
                        x: .value("Date", transaction.date),
                        y: .value("Amount", amount)
                    )
                    .foregroundStyle(.blue)
                }
            }
        }
        .frame(height: 200)
        .padding()
    }
}

// Preview provider for testing
#Preview {
    TransactionsChartView()
}
