//
//  AccountsListView.swift
//  AccountsJourney
//

import BackbaseDesignSystem
import SwiftUI

/// The accounts list. The view model is driven by SwiftUI itself: the first load by `.task`,
/// the search by `.task(id:)` as the search text changes and the reload by `.refreshable`.
struct AccountsListView<ViewModel: AccountsListViewModeling>: View {

    @Bindable private var viewModel: ViewModel
    private let configuration: AccountsJourney.Configuration

    @State private var isPullRefreshing = false

    init(
        viewModel: ViewModel,
        configuration: AccountsJourney.Configuration
    ) {
        self.viewModel = viewModel
        self.configuration = configuration
    }

    var body: some View {
        AccountsListContentView(
            configuration: configuration,
            state: viewModel.state,
            searchText: $viewModel.searchText,
            isRefreshing: isPullRefreshing,
            onSelect: viewModel.select(accountID:),
            onRefresh: pullToRefresh,
            onRetry: { Task { await viewModel.refresh() } }
        )
        .background(Color(Theme.colors.background.page).ignoresSafeArea())
        .navigationTitle(configuration.accountsList.strings.screenTitle())
        .navigationBarTitleDisplayMode(.large)
        .onAppear { viewModel.screenDidAppear() }
        .task { await viewModel.loadAccountsIfNeeded() }
        .task(id: viewModel.searchText) { await viewModel.submitSearch() }
    }

    // MARK: - Private

    private func pullToRefresh() async {
        isPullRefreshing = true
        defer { isPullRefreshing = false }
        await viewModel.pullToRefresh()
    }
}
