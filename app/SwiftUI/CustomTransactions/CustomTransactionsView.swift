import SwiftUI
import AccountsJourney

struct CustomTransactionsView: View {

    @StateObject var viewModel = CustomTransactionsViewModel()

    public init() { }

    public var body: some View {
        NavigationStack {
            VStack {
                if viewModel.state.stateExtension!.graphShown {
                    TransactionsChartView()
                }
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
//                        Task {
//                            await viewModel.handle(.newTransaction))
//                        }
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
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(Color.black,
                                   for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbar {
                    if (viewModel.state.transactions != nil) {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                Task {
                                    await viewModel.handle(ToggleGraphIntent())
                                }
                            }) {
                                Image(systemName: viewModel.state.stateExtension!.graphShown ? "chart.bar.fill" : "chart.bar" )
                            }
                            .foregroundStyle(.white)
                        }
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
}

#Preview {
    CustomTransactionsView()
}


