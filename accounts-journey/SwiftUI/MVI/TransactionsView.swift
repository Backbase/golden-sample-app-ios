import SwiftUI

public struct TransactionsView: View {

    @State var viewModel: Transactions.ViewModel

    public init(client: Client) {
        viewModel = Transactions.ViewModel(Transactions.State(), client: client)
    }

    public var body: some View {
        NavigationStack {
            VStack {
                if viewModel.state.isLoading {
                    LoadingStateView()
                } else if let errorMessage = viewModel.state.errorMessage {
                    ErrorView(message: errorMessage)
                } else if let transactions = viewModel.state.data {
                    TransactionsListView(transactions: transactions)
                }
                Spacer()
                Button(action: {
                    viewModel.sendIntent(.newTransaction)
                }) {
                    Text("New transaction")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .background(Color.black)
                .padding()

            }.onAppear {
                viewModel.sendIntent(.viewAppeared)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.black,
                               for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.sendIntent(.refresh)
                    }) {
                        Image(systemName: "arrow.clockwise")
                    }
                    .foregroundStyle(.white)
                }
                ToolbarItem(placement: .principal) {
                    Text("Transactions")
                        .foregroundColor(.white)
                        .bold()
                }
            }
        }
    }
}

#Preview {
    TransactionsView(client: TransactionsClient())
}
