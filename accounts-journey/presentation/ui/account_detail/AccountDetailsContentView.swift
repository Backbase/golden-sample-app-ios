//
//  AccountDetailsContentView.swift
//  AccountsJourney
//

import BackbaseDesignSystem
import SwiftUI

/// The screen for a given state. It knows nothing about the view model, which keeps it previewable.
struct AccountDetailsContentView: View {

    let configuration: AccountsJourney.Configuration
    let content: AccountDetailsContent?
    let isLoading: Bool
    let error: AccountDetails.Error?
    let onRetry: () -> Void

    var body: some View {
        if let error {
            StateConfigurationView(
                configuration: error.stateViewConfiguration(using: configuration, primaryAction: onRetry),
                appearance: EmblemAppearance.appearance(forBackground: Theme.colors.background.dangerSubtle),
                accessibilityIdentifier: "AccountDetailsStateView"
            )
            .padding(.horizontal, DesignSystem.shared.spacer.md)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if let content {
            AccountDetailsLoadedView(content: content)
        } else if isLoading {
            CustomProgressView()
                .padding(.horizontal, DesignSystem.shared.spacer.md)
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
