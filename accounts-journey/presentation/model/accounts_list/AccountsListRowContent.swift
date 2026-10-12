//
//  AccountsListRowContent.swift
//  ios-golden-sample-app
//
//  Created by Aleh Pachtovy on 09/10/2026.
//

import BackbaseDesignSystem
import Foundation

/// The texts shown by `AccountsListRowView`.
struct AccountsListRowContent: Equatable {

    let name: String
    let state: String?
    let balance: String?

    init(
        account: AccountUIModel,
        strings: AccountsList.Strings,
        formatAmount: (Currency) -> String = AccountsListRowContent.formatAmount
    ) {
        self.name = account.name ?? ""
        self.state = Self.stateText(for: account.state, strings: strings)
        self.balance = account.balance.map(formatAmount)
    }

    /// Closed and inactive accounts use localised captions, any other state is shown as is.
    static func stateText(for state: String?, strings: AccountsList.Strings) -> String? {
        switch state?.lowercased() {
        case "closed":
            return strings.closedAccountSubtitle()
        case "inactive":
            return strings.inactiveAccountSubtitle()
        default:
            return state
        }
    }

    /// Formats the amount with the design system formatter, using the journey's fraction digits.
    static func formatAmount(_ currency: Currency) -> String {
        var options = DesignSystem.Formatting.Options()
        options.customCode = currency.currencyCode
        options.minFractionDigits = DesignSystem.Formatting.defaultFractionDigits
        options.maxFractionDigits = DesignSystem.Formatting.defaultFractionDigits

        return DesignSystem.shared.formatting.amountFormatter.format(
            amount: Decimal(string: currency.amount) ?? 0,
            currencyCode: currency.currencyCode,
            options: options
        ) ?? "\(currency.amount) \(currency.currencyCode)"
    }
}
