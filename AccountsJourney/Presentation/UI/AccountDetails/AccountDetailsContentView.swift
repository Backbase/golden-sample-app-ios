//
//  AccountDetailsContentView.swift
//  AccountsJourney
//

import BackbaseDesignSystem
import SwiftUI

/// The screen for a given state. It knows nothing about the view model, which keeps it previewable.
struct AccountDetailsContentView: View {

    let state: ViewState<AccountDetailsContent>

    var body: some View {
        ViewStateContainer(
            state: state,
            errorAppearance: EmblemAppearance.appearance(forBackground: Theme.colors.background.dangerSubtle),
            errorAccessibilityIdentifier: "AccountDetailsStateView"
        ) { content in
            AccountDetailsLoadedView(content: content)
        }
    }
}

/// The header followed by the sections.
private struct AccountDetailsLoadedView: View {

    let content: AccountDetailsContent

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                AccountDetailsHeaderView(content: content.header)
                ForEach(Array(content.sections.enumerated()), id: \.offset) { _, section in
                    AccountDetailsSectionView(content: section)
                }
            }
            .padding(.top, DesignSystem.shared.spacer.sm)
            .padding(.bottom, DesignSystem.shared.spacer.md)
        }
        .accessibilityIdentifier("AccountDetailsScrollView")
    }
}
