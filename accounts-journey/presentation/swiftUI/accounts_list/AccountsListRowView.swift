//
//  AccountsListRowView.swift
//  AccountsJourney
//

import BackbaseDesignSystem
import Resolver
import SwiftUI

/// SwiftUI replacement of `AccountListItemTableCell`.
struct AccountsListRowView: View {

    private let content: AccountsListRowContent
    private let iconInfo: AccountIconInfo?
    private let identifier: String?
    private let position: CellPosition

    init(
        account: AccountUIModel,
        position: CellPosition,
        configuration: AccountsJourney.Configuration = Resolver.resolve()
    ) {
        self.content = AccountsListRowContent(account: account, strings: configuration.accountsList.strings)
        self.iconInfo = account.iconName
        self.identifier = account.id
        self.position = position
    }

    var body: some View {
        HStack(alignment: .top, spacing: DesignSystem.shared.sizer.sm) {
            if let iconInfo {
                BB.Emblem(
                    icon: Image(uiImage: iconInfo.icon),
                    appearance: EmblemAppearance.appearance(for: iconInfo.backgroundColor.map(Color.init(uiColor:))),
                    layout: .small
                )
            }
            VStack(alignment: .leading, spacing: DesignSystem.shared.sizer.xs) {
                RowText(content.name, role: .name)
                if let state = content.state {
                    RowText(state, role: .state)
                }
                if let balance = content.balance {
                    RowText(balance, role: .balance)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(DesignSystem.shared.spacer.md)
        .background(Color(Theme.colors.background.surface1))
        .groupedRowCorners(position)
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier(identifier.map { "AccountsListRow_\($0)" } ?? "AccountsListRow")
    }

}

/// A single line of the row. Fonts and colours are the design system tokens used by the
/// default `accountName`, `accountState` and `accountBalance` styles.
private struct RowText: View {

    enum Role {
        case name, state, balance
    }

    private let value: String
    private let role: Role

    init(_ value: String, role: Role) {
        self.value = value
        self.role = role
    }

    var body: some View {
        styled
            .multilineTextAlignment(role == .balance ? .trailing : .leading)
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: .infinity, alignment: role == .balance ? .trailing : .leading)
    }

    @ViewBuilder
    private var styled: some View {
        switch role {
        case .name:
            Text(value)
                .scaledFont(weight: .semibold, style: .subheadline)
                .foregroundStyle(Color(Theme.colors.foreground.default))
        case .state:
            Text(value)
                .scaledFont(weight: .semibold, style: .subheadline)
                .foregroundStyle(Color(Theme.colors.foreground.support))
        case .balance:
            Text(value)
                .scaledFont(weight: .regular, style: .subheadline)
                .foregroundStyle(Color(Theme.colors.foreground.default))
        }
    }
}

// MARK: - Content

/// The texts shown by `AccountsListRowView`. Same rules as the default
/// `accountListRowProvider` used by the UIKit cell, expressed as plain `String`s.
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

#if DEBUG
#Preview("Rows") {
    Resolver.register { AccountsJourney.Configuration() }
    let accounts = [
        AccountUIModel(
            id: "1",
            name: "Main account",
            balance: Currency(amount: "1250.50", currencyCode: "EUR"),
            state: "Active",
            iconName: AccountIconInfo(
                icon: UIImage(systemName: "creditcard") ?? UIImage(),
                backgroundColor: Theme.colors.background.brandSubtle
            )
        ),
        AccountUIModel(
            id: "2",
            name: "Savings",
            balance: Currency(amount: "9800", currencyCode: "EUR"),
            state: "Inactive",
            iconName: AccountIconInfo(
                icon: UIImage(systemName: "banknote") ?? UIImage(),
                backgroundColor: Theme.colors.background.successSubtle
            )
        ),
        AccountUIModel(
            id: "3",
            name: "Loan",
            balance: Currency(amount: "-12000", currencyCode: "EUR"),
            state: "Closed",
            iconName: AccountIconInfo(
                icon: UIImage(systemName: "percent") ?? UIImage(),
                backgroundColor: Theme.colors.background.category2Subtle
            )
        )
    ]
    return VStack(spacing: 0) {
        ForEach(Array(accounts.enumerated()), id: \.offset) { index, account in
            AccountsListRowView(
                account: account,
                position: .position(forRow: index, count: accounts.count)
            )
        }
    }
    .padding()
    .background(Color(Theme.colors.background.page))
}
#endif
