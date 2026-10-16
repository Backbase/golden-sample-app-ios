//
//  AccountDetailsContentMapper.swift
//  AccountsJourney
//

import BackbaseDesignSystem
import Foundation

/// Turns an `AccountDetailsData` into the formatted and localised `AccountDetailsContent` the screen shows.
///
/// Stateless: owned by the view model, which decides when to map. The amount formatter is injectable,
/// so the mapping can be tested without the design system.
struct AccountDetailsContentMapper {

    private let strings: AccountDetails.Strings
    private let formatAmount: (_ amount: Double, _ currencyCode: String) -> String

    /// - Parameters:
    ///   - strings: The localised texts of the screen.
    ///   - formatAmount: Formats an amount in a currency for display. Defaults to the design system formatter.
    init(
        strings: AccountDetails.Strings,
        formatAmount: @escaping (_ amount: Double, _ currencyCode: String) -> String = AccountDetailsContentMapper.designSystemAmount
    ) {
        self.strings = strings
        self.formatAmount = formatAmount
    }

    // MARK: - Mapping

    func content(for details: AccountDetailsData) -> AccountDetailsContent {
        AccountDetailsContent(
            header: header(for: details),
            sections: sections(for: details)
        )
    }

    /// The icon, the product name, the account number, the available balance and the credit limit.
    func header(for details: AccountDetailsData) -> AccountDetailsHeaderContent {
        AccountDetailsHeaderContent(
            icon: details.iconName,
            title: details.productKindName,
            subtitle: details.BBAN,
            balance: formatAmount(details.availableBalance, details.currency),
            limit: "\(strings.limitTitle()) \(formatAmount(details.creditLimit, details.currency))"
        )
    }

    /// The details, general and status sections, in the order they are shown.
    func sections(for details: AccountDetailsData) -> [AccountDetailsSectionContent] {
        [
            detailsSection(for: details),
            generalSection(for: details),
            statusSection(for: details)
        ]
    }

    // MARK: - Sections

    /// First section: holder names and card or account number. It has a blank title, which keeps
    /// the same vertical spacing as the sections with a title.
    private func detailsSection(for details: AccountDetailsData) -> AccountDetailsSectionContent {
        AccountDetailsSectionContent(
            title: "",
            rows: [
                AccountDetailsRowContent(title: strings.holderNamesTitle(), subtitle: details.displayName),
                AccountDetailsRowContent(title: strings.cardOrAccountNumberTitle(), subtitle: details.BBAN)
            ]
        )
    }

    /// "General" section: account type and account name.
    private func generalSection(for details: AccountDetailsData) -> AccountDetailsSectionContent {
        AccountDetailsSectionContent(
            title: strings.generalSectionTitle().uppercased(),
            rows: [
                AccountDetailsRowContent(title: strings.accountTypeTitle(), subtitle: details.productKindName),
                AccountDetailsRowContent(title: strings.accountNameTitle(), subtitle: details.productKindName)
            ]
        )
    }

    /// "Status" section: account status, blank without one.
    private func statusSection(for details: AccountDetailsData) -> AccountDetailsSectionContent {
        AccountDetailsSectionContent(
            title: strings.statusSectionTitle().uppercased(),
            rows: [
                AccountDetailsRowContent(title: strings.accountStatusTitle(), subtitle: details.accountState ?? "")
            ]
        )
    }

    // MARK: - Formatting

    /// Formats the amount with the design system formatter, in the account currency.
    static func designSystemAmount(_ amount: Double, currencyCode: String) -> String {
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
