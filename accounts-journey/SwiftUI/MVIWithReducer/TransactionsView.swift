import SwiftUI

struct TransactionsView: View {

    @State var viewModel = ViewModel(initialState: TransactionsViewState.initial, reducer: TransactionsReducer())

    var body: some View {
        NavigationStack{
            VStack {
                if viewModel.state.isLoading {
                    LoadingStateView()
                }
                else if let errorMessage = viewModel.state.errorMessage {
                    ErrorView(message: errorMessage)
                } else if let transactions = viewModel.state.transactions {
                    TransactionsListView(transactions: transactions)
                }
                Spacer()
                Button(action: {
                    viewModel.send(.newTransaction)
                }) {
                    Text("New transaction")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .background(Color.black)
                .padding()

            }.onAppear {
                viewModel.send(.viewAppeared)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.black,
                               for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.send(.refresh)
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
