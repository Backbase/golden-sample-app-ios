import Foundation
import Combine

final class TransactionsReducer: Reducer {
    typealias ViewState = TransactionsViewState
    typealias ViewEvent = TransactionsViewEvent

    private let client = TransactionsClient()
    
    func reduce(_ state: inout ViewState, event: ViewEvent) -> Effect<ViewEvent> {
        switch event {
        case .viewAppeared:
            state = TransactionsViewState(isLoading: true, errorMessage: nil, transactions: nil)
            return Effect(publisher: Future<ViewEvent, Never> { promise in
                self.client.getTransactions { result in
                    promise(.success(.processTransactionsResponse(result)))
                }

            }.eraseToAnyPublisher())
        case .refresh:
            //async-await API
//            state = TransactionsViewState(isLoading: true, errorMessage: nil, transactions: nil)
//            return Effect.task {
//                let result = await self.client.fetchTransactions()
//                return .processTransactionsResponse(result)
//            }

              //completion based API
            return Effect(publisher: Future<ViewEvent, Never> { promise in
                self.client.getTransactions { result in
                    promise(.success(.processTransactionsResponse(result)))
                }
            }.eraseToAnyPublisher())
        case .processTransactionsResponse(let result):
            switch result {
            case .success(let transactionsDTOs):
                let transactions = transactionsDTOs.map { Transaction(from: $0) }
                state = TransactionsViewState(isLoading: false, errorMessage: nil, transactions: transactions)
            case .failure(let error):
                state = TransactionsViewState(isLoading: false, errorMessage: error.localizedDescription, transactions: nil)
            }
            return .none
        case .newTransaction:
            return .none
        }
    }
}
