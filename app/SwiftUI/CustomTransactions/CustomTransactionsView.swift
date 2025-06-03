import SwiftUI
import UIKit
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
                    HStack {
                        Button(action: {
                            Task {
                                await viewModel.handle(ToggleGraphIntent())
                            }
                        }) {
                            Image(systemName: viewModel.state.stateExtension!.graphShown ? "chart.bar.fill" : "chart.bar" )
                                .resizable()
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 50, height: 50)
                        }
                        .background(Color.black)
                        Button(action: {
                            Task {
                                await viewModel.handle(NewTransactionIntent())
                            }
                        }) {
                            Text("New transaction")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: 50)
                        }                        .background(Color.black)


                    }
                    .padding()
                }.onAppear {
                    Task {
                        await viewModel.handle(ViewAppearedIntent())
                    }
                }
            }
        }
    }

    static func build(navigationController: UINavigationController) -> UIViewController {
        let view = CustomTransactionsView()
        let controller = UIHostingController(rootView: view)
        return controller
    }
}

#Preview {
    CustomTransactionsView()
}
