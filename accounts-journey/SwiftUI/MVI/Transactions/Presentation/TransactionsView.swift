import SwiftUI

public struct TransactionsView: View {

    @StateObject var viewModel = TransactionsViewModel<Void>()

    public init() { }

    public var body: some View {
            VStack {
                if viewModel.state.isLoading {
                    LoadingStateView()
                } else if let errorMessage = viewModel.state.errorMessage {
                    ErrorView(message: errorMessage, onRefresh: {
                        Task {
                            await viewModel.handle(RefreshIntent())
                        }
                    })
                } else if let transactions = viewModel.state.transactions {
                    TransactionsListView(transactions: transactions, onRefresh: {
                        Task {
                            await viewModel.handle(RefreshIntent())
                        }
                    })
                }
                Spacer()
                Button(action: {
                    print("Lofasz")
                    /*Task {
                        await viewModel.handle()
                    }*/
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
                    await viewModel.handle(ViewAppearedIntent())
                }
        }
    }
}

#Preview {
    TransactionsView()
}
