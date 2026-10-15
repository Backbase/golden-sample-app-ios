//
//  AccountDetailsView.swift
//  AccountsJourney
//

import BackbaseDesignSystem
import SwiftUI

/// The account details. The view model is driven by SwiftUI itself: the load by `.task`,
/// the retry by the error state's button.
struct AccountDetailsView<ViewModel: AccountDetailsViewModeling>: View {

    private let viewModel: ViewModel
    private let configuration: AccountsJourney.Configuration

    init(
        viewModel: ViewModel,
        configuration: AccountsJourney.Configuration
    ) {
        self.viewModel = viewModel
        self.configuration = configuration
    }

    var body: some View {
        AccountDetailsContentView(
            configuration: configuration,
            details: viewModel.details,
            isLoading: viewModel.isLoading,
            error: viewModel.error,
            onRetry: { Task { await viewModel.load() } }
        )
        .background(Color(Theme.colors.background.page).ignoresSafeArea())
        .navigationTitle(configuration.accountDetails.strings.screenTitle())
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { viewModel.screenDidAppear() }
        .task { await viewModel.loadIfNeeded() }
    }
}

// MARK: - Content

/// The screen for a given state. It knows nothing about the view model, which keeps it previewable.
struct AccountDetailsContentView: View {

    let configuration: AccountsJourney.Configuration
    let details: AccountDetailsUIModel?
    let isLoading: Bool
    let error: AccountDetails.Error?
    let onRetry: () -> Void

    var body: some View {
        if let error {
            StateConfigurationView(
                configuration: error.stateViewConfiguration(configuration: configuration, primaryAction: onRetry),
                appearance: EmblemAppearance.appearance(forBackground: Theme.colors.background.dangerSubtle),
                accessibilityIdentifier: "AccountDetailsStateView"
            )
            .padding(.horizontal, DesignSystem.shared.spacer.md)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if let details {
            AccountDetailsLoadedView(details: details, strings: configuration.accountDetails.strings)
        } else if isLoading {
            CustomProgressView()
                .padding(.horizontal, DesignSystem.shared.spacer.md)
        }
    }
}

/// The header followed by the details, general and status sections.
struct AccountDetailsLoadedView: View {

    let details: AccountDetailsUIModel
    let strings: AccountDetails.Strings

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                AccountDetailsHeaderView(content: AccountDetailsHeaderContent(details: details, strings: strings))
                AccountDetailsSectionView(content: .details(for: details, strings: strings))
                AccountDetailsSectionView(content: .general(for: details, strings: strings))
                AccountDetailsSectionView(content: .status(for: details, strings: strings))
            }
            .padding(.top, DesignSystem.shared.spacer.sm)
            .padding(.bottom, DesignSystem.shared.spacer.md)
        }
        .accessibilityIdentifier("AccountDetailsScrollView")
    }
}
