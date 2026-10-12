//
//  AccountDetailsSectionView.swift
//  AccountsJourney
//

import BackbaseDesignSystem
import SwiftUI

/// SwiftUI replacement of `AccountDetailsUsageView`.
///
/// Shows an optional section title above a card with one `AccountDetailsRowView` per row. Fonts and
/// colours are the design system tokens used by the default `accountDetailSectionTitle` style.
struct AccountDetailsSectionView: View {

    private let content: AccountDetailsSectionContent

    init(content: AccountDetailsSectionContent) {
        self.content = content
    }

    var body: some View {
        VStack(alignment: .leading, spacing: DesignSystem.shared.spacer.xs) {
            if let title = content.title {
                Text(title)
                    .scaledFont(weight: .regular, style: .footnote)
                    .foregroundStyle(Color(Theme.colors.foreground.support))
                    .padding(.horizontal, DesignSystem.shared.spacer.lg)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .accessibilityAddTraits(.isHeader)
            }
            card
        }
        .padding(.bottom, DesignSystem.shared.spacer.md)
    }

    private var card: some View {
        VStack(alignment: .leading, spacing: DesignSystem.shared.spacer.md) {
            ForEach(Array(content.rows.enumerated()), id: \.offset) { _, row in
                AccountDetailsRowView(content: row)
            }
        }
        .padding(DesignSystem.shared.spacer.md)
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardViewStyle()
        .padding(.horizontal, DesignSystem.shared.spacer.md)
    }
}

#if DEBUG
#Preview("Account Details section") {
    ScrollView {
        VStack(spacing: DesignSystem.shared.spacer.sm) {
            AccountDetailsSectionView(
                content: AccountDetailsSectionContent(
                    title: " ",
                    rows: [
                        AccountDetailsRowContent(title: "Account holder names", subtitle: "John Doe"),
                        AccountDetailsRowContent(title: "Card or account number", subtitle: "NL91ABNA0417164300")
                    ]
                )
            )
            AccountDetailsSectionView(
                content: AccountDetailsSectionContent(
                    title: "",
                    rows: [
                        AccountDetailsRowContent(title: "Account type", subtitle: "Current account"),
                        AccountDetailsRowContent(title: "Account name", subtitle: "Main account")
                    ]
                )
            )
            AccountDetailsSectionView(
                content: AccountDetailsSectionContent(
                    title: "Status",
                    rows: [AccountDetailsRowContent(title: "Account status", subtitle: "Active")]
                )
            )
        }
    }
    .background(Color(Theme.colors.background.page))
}
#endif
