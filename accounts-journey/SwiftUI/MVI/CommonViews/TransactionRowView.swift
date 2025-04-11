import SwiftUI

struct TransactionRowView: View {

    let transaction: Transaction

    var body: some View {
        HStack {
            Image(systemName: transaction.iconName)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.black)
                .padding(10)
                .background(Color.white) // Optional: Background color to make corner radius visible
                .cornerRadius(2) // Apply corner radius
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.black, lineWidth: 1) // Creates a border with rounded corners
                )
            VStack (alignment: .leading) {
                HStack {
                    Text(transaction.name)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Spacer()
                    Text(transaction.amount)
                        .fontWeight(.semibold)
                }
                Text(transaction.date)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    let sample = Transaction(id: "0",
                              date: "1 January 2025, 10:00",
                              name: "Apple services",
                              amount: "€ -19.0",
                              iconName: "arrow.down.right.circle.fill")
    TransactionRowView(transaction: sample)
}
