import SwiftUI

public struct TransactionsView: View {

    @StateObject var viewModel = TransactionsViewModel<Void, Void>()

    public init() { }

    public var body: some View {
            VStack {
                switch viewModel.state {
                case .loading:
                    LoadingStateView()
                case .loaded(let transactionsData):
                    TransactionsListView(transactions: transactionsData.transactions,
                                         onRefresh: {
                        Task {
                            await viewModel.handle(RefreshIntent())
                        }
                    })
                case .error(let errorData):
                    ErrorView(message: errorData.errorMessage, onRefresh: {
                        Task {
                            await viewModel.handle(RefreshIntent())
                        }
                    })
                case .custom:
                    fatalError("Unexpected state in TransactionsView")
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
