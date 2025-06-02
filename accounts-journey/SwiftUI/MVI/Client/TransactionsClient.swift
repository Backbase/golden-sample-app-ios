import Foundation

public enum TransactionClientError: Error {
    case apiError
}

public protocol TransactionsClient {
    func getTransactions(completion: @escaping (Result<[TransactionDTO], TransactionClientError>) -> Void)
    func fetchTransactions() async -> Result<[TransactionDTO], TransactionClientError>
}

final public class DefaultTransactionsClient: TransactionsClient, Sendable {
    
    public init () {}

    public func getTransactions(completion: @escaping (Result<[TransactionDTO], TransactionClientError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let result = (Int.random(in: 0...100) % 5 == 0) ? Result.failure(TransactionClientError.apiError) : Result.success(self.generateTestTransactions(count: 20))
            completion(result)
        }
    }

    public func fetchTransactions() async -> Result<[TransactionDTO], TransactionClientError> {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        return (Int.random(in: 0...100) % 5 == 0) ? Result.failure(TransactionClientError.apiError) : Result.success(generateTestTransactions(count: 20))
    }

    private func generateTestTransactions(count: Int) -> [TransactionDTO] {
        let transactionTypes: [TransactionType] = [.cashWithdrawal, .directDebit, .cardPayment]
        let currencies = ["USD", "EUR", "GBP"]
        let names = ["Grocery Store", "Online Subscription", "Coffee Shop", "Gas Station", "Clothing Store"]

        var transactions: [TransactionDTO] = []

        for _ in 0..<count {
            let randomType = transactionTypes.randomElement()!
            let randomCurrency = currencies.randomElement()!
            let randomName = names.randomElement()!
            let randomAmount = Double.random(in: 1.0...500.0)
            let randomDate = Date().addingTimeInterval(-Double.random(in: 0...60*60*24*30))

            let transaction = TransactionDTO(
                id: UUID().uuidString,
                date: randomDate,
                name: randomName,
                amount: randomAmount,
                currency: randomCurrency,
                transactionType: randomType
            )

            transactions.append(transaction)
        }
        transactions = transactions.sorted(by: { $0.date > $1.date })
        return transactions
    }
}
