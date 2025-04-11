import Foundation

public enum TransactionType: Sendable {
    case cashWithdrawal
    case directDebit
    case cardPayment
}

public struct TransactionDTO: Sendable {
    public let id: String
    public let date: Date
    public let name: String
    public let amount: Double
    public let currency: String
    public let transactionType: TransactionType
}
