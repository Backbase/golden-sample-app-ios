import SwiftUI
import UIKit
import AccountsJourney

struct CustomTransactionsView: View {

    @StateObject var viewModel = TransactionsViewModel<CustomTransactionsState, CustomData>.Builder()
        .with(initialState: .loading(TransactionsState.LoadingData(stateExtension: CustomData(graphShown: true))))
        .with(additionalHandlers: [ToggleGraphHandler()])
        .build()

    public init() { }

    public var body: some View {
        NavigationStack {
            VStack {
                if viewModel.state.isGraphShown {
                    TransactionsChartView()
                }
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
                    HStack {
                        Button(action: {
                            Task {
                                await viewModel.handle(ToggleGraphIntent())
                            }
                        }) {
                            Image(systemName: viewModel.state.isGraphShown ? "chart.bar.fill" : "chart.bar" )
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
                }.onReceive(viewModel.effectSubject) { effect in
                    print("Received effect in CustomTransactionsView: \(effect)")
                    // Handle navigation effects here
                    switch effect {
                    case .navigateToNewTransaction:
                        // Handle navigation to new transaction
                        print("Navigate to new transaction from custom view")
                    }
                }
            }
        }
    }

    static func build(navigationController: UINavigationController) -> UIViewController {
        let view = CustomTransactionsView()
        let controller = UIHostingController(rootView: view)
        controller.title = "Custom Transactions"
        return controller
    }
}

#Preview {
    CustomTransactionsView()
}
