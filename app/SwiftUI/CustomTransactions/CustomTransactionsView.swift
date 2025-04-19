import SwiftUI
import AccountsJourney

struct CustomTransactionsView: View {

    @State var viewModel: CustomViewModel
    public init(client: Client) {
        viewModel = CustomViewModel(CustomData(), client: client)
    }

    public var body: some View {
        NavigationStack {
            VStack {
                if viewModel.state.graphShown {
                    TransactionsChartView()
                }
                VStack {
                    if viewModel.state.transactions.isLoading {
                        LoadingStateView()
                    } else if let errorMessage = viewModel.state.transactions.errorMessage {
                        ErrorView(message: errorMessage)
                    } else if let transactions = viewModel.state.transactions.data {
                        TransactionsListView(transactions: transactions)
                    }
                    Spacer()
                    Button(action: {
                       viewModel.sendIntent(.transactions(.newTransaction))
                    }) {
                        Text("New transaction")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                    }
                    .background(Color.black)
                    .padding()
                    
                }.onAppear {
                    viewModel.sendIntent(.transactions(.viewAppeared))
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(Color.black,
                                   for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbar {
                    if viewModel.state.transactions.data != nil {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                viewModel.sendIntent(.toggleGraph)
                            }) {
                                Image(systemName: viewModel.state.graphShown ? "chart.bar.fill" : "chart.bar" )
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
                            viewModel.sendIntent(.transactions(.refresh))
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
    CustomTransactionsView(client: TransactionsClient())
}
