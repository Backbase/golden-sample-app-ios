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
                    Task {
                        await viewModel.handle(NewTransactionIntent())
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
                    await viewModel.handle(ViewAppearedIntent())
                }
            }.onChange(of: viewModel.effect) { oldValue, newValue in
                if let newValue = newValue {
                    print(newValue)
                }
            }
    }
}
//
#Preview {
    TransactionsView()
}
