import SwiftUI
import AccountsJourney

struct CustomTransactionsView: View {

    @StateObject var viewModel = CustomTransactionsViewModel(initialState: TransactionsState(isLoading: true,
                                                                                                   errorMessage: nil, transactions: nil, stateExtension: CustomData(graphShown: false)))
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
                        ErrorView(message: errorMessage)
                    } else if let transactions = viewModel.state.transactions {
                        TransactionsListView(transactions: transactions)
                    }
                    Spacer()
                    Button(action: {
                        Task {
                            await viewModel.handleIntent(.defaultIntent(.newTransaction))
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
                        await viewModel.handleIntent(.defaultIntent(.viewAppeared))
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
                                    await viewModel.handleIntent(.toggleGraph)
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
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            Task {
                                await viewModel.handleIntent(.defaultIntent(.refresh))
                            }
                        }) {
                            Image(systemName: "arrow.clockwise")
                        }
                        .foregroundStyle(.white)
                    }
                }
            }
        }
    }
}

#Preview {
    CustomTransactionsView()
}
