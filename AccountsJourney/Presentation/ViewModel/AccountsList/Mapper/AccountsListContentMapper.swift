//
//  AccountsListContentMapper.swift
//  AccountsJourney
//

import BackbaseDesignSystem
import Foundation

/// Turns an `AccountData` into the formatted and localised `AccountsListRowContent` the list shows.
///
/// Stateless: owned by the view model, which decides when to map. The amount formatter is injectable,
/// so the mapping can be tested without the design system.
struct AccountsListContentMapper {

    private let strings: AccountsList.Strings
    private let formatAmount: (Currency) -> String

    /// - Parameters:
    ///   - strings: The localised texts of the screen.
    ///   - formatAmount: Formats a balance for display. Defaults to the design system formatter.
    init(
        strings: AccountsList.Strings,
        formatAmount: @escaping (Currency) -> String = AccountsListContentMapper.designSystemAmount
    ) {
        self.strings = strings
        self.formatAmount = formatAmount
    }

    // MARK: - Mapping

    func rows(for accounts: [AccountData]) -> [AccountsListRowContent] {
        accounts.map(row(for:))
    }

    func row(for account: AccountData) -> AccountsListRowContent {
        AccountsListRowContent(
            id: account.id,
            icon: account.iconName,
            name: account.name ?? "",
            state: stateText(for: account.state),
            balance: account.balance.map(formatAmount)
        )
    }

    /// Closed and inactive accounts use localised captions, any other state is shown as is.
    func stateText(for state: String?) -> String? {
        switch state?.lowercased() {
        case "closed":
            return strings.closedAccountSubtitle()
        case "inactive":
            return strings.inactiveAccountSubtitle()
        default:
            return state
        }
    }

    // MARK: - Formatting

    /// Formats the amount with the design system formatter, using the journey's fraction digits.
    static func designSystemAmount(_ currency: Currency) -> String {
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
