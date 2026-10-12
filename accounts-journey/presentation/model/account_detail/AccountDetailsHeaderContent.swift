//
//  AccountDetailsHeaderContent.swift
//  AccountsJourney
//

import BackbaseDesignSystem
import Foundation

/// The texts and the icon shown by `AccountDetailsHeaderView`.
struct AccountDetailsHeaderContent: Equatable {

    let icon: AccountIconInfo?
    let title: String
    let subtitle: String
    let balance: String
    let limit: String

    init(
        icon: AccountIconInfo?,
        title: String,
        subtitle: String,
        balance: String,
        limit: String
    ) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.balance = balance
        self.limit = limit
    }

    init(
        details: AccountDetailsUIModel,
        strings: AccountDetails.Strings,
        formatAmount: (Double, String) -> String = AccountDetailsHeaderContent.formatAmount
    ) {
        self.init(
            icon: details.iconName,
            title: details.productKindName,
            subtitle: details.BBAN,
            balance: formatAmount(details.availableBalance, details.currency),
            limit: "\(strings.limitTitle()) \(formatAmount(details.creditLimit, details.currency))"
        )
    }

    /// Formats the amount with the design system formatter, in the account currency.
    static func formatAmount(_ amount: Double, currencyCode: String) -> String {
        let code = currencyCode.isEmpty ? nil : currencyCode
        var options = DesignSystem.Formatting.Options()
        options.customCode = code

        return DesignSystem.shared.formatting.amountFormatter.format(
            amount: Decimal(amount),
            currencyCode: code,
            options: options
        ) ?? "\(amount)"
    }
}
