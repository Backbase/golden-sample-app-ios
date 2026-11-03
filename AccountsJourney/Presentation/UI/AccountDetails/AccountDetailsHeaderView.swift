//
//  AccountDetailsHeaderView.swift
//  AccountsJourney
//

import BackbaseDesignSystem
import SwiftUI

/// Centers the account icon, the product name, the account number, the available balance and the
/// credit limit in a vertical stack. Fonts, colours and spacing are design system tokens.
struct AccountDetailsHeaderView: View {

    private let content: AccountDetailsHeaderContent

    init(content: AccountDetailsHeaderContent) {
        self.content = content
    }

    var body: some View {
        VStack(spacing: DesignSystem.shared.spacer.xs) {
            if let icon = content.icon {
                BB.Emblem(
                    icon: Image(uiImage: icon.icon),
                    appearance: EmblemAppearance.appearance(forBackground: icon.backgroundColor),
                    layout: .small
                )
                .padding(.bottom, DesignSystem.shared.spacer.xs)
                .accessibilityHidden(true)
            }
            Text(content.title)
                .scaledFont(weight: .semibold, style: .subheadline)
                .foregroundStyle(Color(Theme.colors.foreground.default))
            Text(content.subtitle)
                .scaledFont(weight: .regular, style: .subheadline)
                .foregroundStyle(Color(Theme.colors.foreground.support))
            Text(content.balance)
                .scaledFont(weight: .regular, style: .subheadline)
                .foregroundStyle(Color(Theme.colors.foreground.support))
            Text(content.limit)
                .scaledFont(weight: .regular, style: .subheadline)
                .foregroundStyle(Color(Theme.colors.foreground.support))
        }
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, DesignSystem.shared.spacer.md)
        .accessibilityElement(children: .combine)
    }
}

#if DEBUG
#Preview("Account Details header") {
    AccountDetailsHeaderView(
        content: AccountDetailsHeaderContent(
            icon: AccountIconInfo(
                icon: UIImage(systemName: "creditcard") ?? UIImage(),
                backgroundColor: Theme.colors.background.brandSubtle
            ),
            title: "Current Account",
            subtitle: "****************0025",
            balance: "$3,207.61",
            limit: "Limit $1,055.50"
        )
    )
    .padding(.vertical)
    .background(Color(Theme.colors.background.page))
}
#endif
