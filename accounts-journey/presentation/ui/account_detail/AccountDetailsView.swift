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
            content: viewModel.content,
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
