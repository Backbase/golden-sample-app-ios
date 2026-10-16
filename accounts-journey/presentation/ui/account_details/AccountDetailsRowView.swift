//
//  AccountDetailsRowView.swift
//  AccountsJourney
//

import BackbaseDesignSystem
import SwiftUI

/// Shows a title and a subtitle stacked vertically, styled with design system tokens.
struct AccountDetailsRowView: View {

    private let content: AccountDetailsRowContent

    init(content: AccountDetailsRowContent) {
        self.content = content
    }

    var body: some View {
        VStack(alignment: .leading, spacing: DesignSystem.shared.spacer.sm) {
            Text(content.title)
                .scaledFont(weight: .semibold, style: .subheadline)
                .foregroundStyle(Color(Theme.colors.foreground.default))
                .fixedSize(horizontal: false, vertical: true)
            Text(content.subtitle)
                .scaledFont(weight: .semibold, style: .subheadline)
                .foregroundStyle(Color(Theme.colors.foreground.support))
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .accessibilityElement(children: .combine)
    }
}

#if DEBUG
#Preview("Account Details section row") {
    VStack(spacing: DesignSystem.shared.spacer.md) {
        AccountDetailsRowView(
            content: AccountDetailsRowContent(title: "Account holder names", subtitle: "John Doe")
        )
        AccountDetailsRowView(
            content: AccountDetailsRowContent(title: "Card or account number", subtitle: "NL91ABNA0417164300")
        )
    }
    .padding()
    .background(Color(Theme.colors.background.page))
}
#endif
