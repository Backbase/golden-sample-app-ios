import SwiftUI

public struct TransactionsView: View {

    @StateObject var viewModel = TransactionsViewModel<Void>(initialState: TransactionsState<Void>())

    public init() { }

    public var body: some View {
        NavigationStack {
            VStack {
                if viewModel.state.isLoading {
                    LoadingStateView()
                } else if let errorMessage = viewModel.state.errorMessage {
                    ErrorView(message: errorMessage)
                } else if let transactions = viewModel.state.transactions {
                    TransactionsListView(transactions: transactions)
                }
                Spacer()
                Button(action: {
                    Task {
                        await viewModel.handleIntent( .newTransaction)
                    }
                }) {
                    Text("New transaction")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .background(Color.black)
                .padding()

            }.onAppear {
                Task {
                    await viewModel.handleIntent( .viewAppeared)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.black,
                               for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        Task {
                            await viewModel.handleIntent( .refresh)
                        }
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
    TransactionsView()
}
