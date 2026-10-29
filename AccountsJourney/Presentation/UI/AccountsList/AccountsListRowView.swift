//
//  AccountsListRowView.swift
//  AccountsJourney
//

import BackbaseDesignSystem
import SwiftUI

struct AccountsListRowView: View {

    private let content: AccountsListRowContent

    init(content: AccountsListRowContent) {
        self.content = content
    }

    var body: some View {
        HStack(alignment: .top, spacing: DesignSystem.shared.sizer.sm) {
            if let iconInfo = content.icon {
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
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier(content.id.map { "AccountsListRow_\($0)" } ?? "AccountsListRow")
    }

}

/// A single line of the row, styled with design system tokens.
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

#if DEBUG
#Preview("Rows") {
    let rows = AccountsListContentMapper(strings: AccountsList.Strings()).rows(for: [
        AccountData(
            id: "1",
            name: "Main account",
            balance: Currency(amount: "1250.50", currencyCode: "EUR"),
            state: "Active",
            iconName: AccountIconInfo(
                icon: UIImage(systemName: "creditcard") ?? UIImage(),
                backgroundColor: Theme.colors.background.brandSubtle
            )
        ),
        AccountData(
            id: "2",
            name: "Savings",
            balance: Currency(amount: "9800", currencyCode: "EUR"),
            state: "Inactive",
            iconName: AccountIconInfo(
                icon: UIImage(systemName: "banknote") ?? UIImage(),
                backgroundColor: Theme.colors.background.successSubtle
            )
        ),
        AccountData(
            id: "3",
            name: "Loan",
            balance: Currency(amount: "-12000", currencyCode: "EUR"),
            state: "Closed",
            iconName: AccountIconInfo(
                icon: UIImage(systemName: "percent") ?? UIImage(),
                backgroundColor: Theme.colors.background.category2Subtle
            )
        )
    ])
    return VStack(spacing: 0) {
        ForEach(Array(rows.enumerated()), id: \.offset) { _, row in
            AccountsListRowView(content: row)
                .background(Color(Theme.colors.background.surface1))
        }
    }
    .clipShape(RoundedRectangle(cornerRadius: DesignSystem.shared.cornerRadius.large))
    .padding()
    .background(Color(Theme.colors.background.page))
}
#endif
