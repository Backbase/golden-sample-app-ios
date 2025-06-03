import Foundation

public struct TransactionData: Identifiable, Equatable {
    public let id: String
    public let date: String
    public let name: String
    public let amount: String
    public let iconName: String

    init (from dto: TransactionDTO) {
        id = dto.id
        date = DateFormatters.default.string(from: dto.date)
        name = dto.name
        iconName = switch dto.transactionType {
            case .cashWithdrawal: "dollarsign.circle.fill"
            case .directDebit: "arrow.down.right.circle.fill"
            case .cardPayment: "creditcard.fill"
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency

        if let locale = Locale.availableIdentifiers.first(where: { Locale(identifier: $0).currency?.identifier == dto.currency }) {
               formatter.locale = Locale(identifier: locale)
           }
        amount = formatter.string(from: NSNumber(value: dto.amount))!
    }

    public init(id: String, date: String, name: String, amount: String, iconName: String) {
        self.id = id
        self.date = date
        self.name = name
        self.amount = amount
        self.iconName = iconName
    }
}
