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
            accounts: viewModel.accounts,
            isLoading: viewModel.isLoading,
            error: viewModel.error,
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

// MARK: - Content

/// The screen for a given state. It knows nothing about the view model, which keeps it previewable.
struct AccountsListContentView: View {

    let configuration: AccountsJourney.Configuration
    let accounts: [AccountUIModel]
    let isLoading: Bool
    let error: AccountsList.Error?
    @Binding var searchText: String
    let isRefreshing: Bool
    let onSelect: (String) -> Void
    let onRefresh: () async -> Void
    let onRetry: () -> Void

    private static let stateViewIdentifier = "AccountsListStateView"
    private static let scrollViewIdentifier = "AccountsListScrollView"

    /// Owned here, not by the search bar, so a row tap can dismiss the keyboard.
    @FocusState private var isSearchFocused: Bool

    var body: some View {
        if let error {
            StateConfigurationView(
                configuration: error.stateViewConfiguration(configuration: configuration, primaryAction: onRetry),
                appearance: EmblemAppearance.appearance(for: Color(Theme.colors.background.dangerSubtle)),
                accessibilityIdentifier: Self.stateViewIdentifier
            )
            .padding(.horizontal, DesignSystem.shared.spacer.md)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            list
        }
    }

    /// Hidden until there is something to search, and kept while a search has no results so
    /// the query can still be edited.
    private var showsSearchBar: Bool {
        !accounts.isEmpty || !searchText.isEmpty
    }

    private var showsEmptyState: Bool {
        !isLoading && accounts.isEmpty
    }

    private var showsProgress: Bool {
        isLoading && !isRefreshing
    }

    private var list: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                if showsSearchBar {
                    AccountsSearchBarView(text: $searchText, isFocused: $isSearchFocused, configuration: configuration)
                }
                if showsEmptyState {
                    StateConfigurationView(
                        configuration: AccountsList.Error.noAccounts.stateViewConfiguration(
                            configuration: configuration,
                            primaryAction: onRetry
                        ),
                        appearance: EmblemAppearance.appearance(for: Color(Theme.colors.background.neutralSubtle)),
                        accessibilityIdentifier: Self.stateViewIdentifier
                    )
                    .padding(.top, DesignSystem.shared.sizer.xl)
                } else {
                    rows
                }
            }
            .padding(DesignSystem.shared.spacer.md)
        }
        .scrollIndicators(.hidden)
        .scrollDismissesKeyboard(.immediately)
        .accessibilityIdentifier(Self.scrollViewIdentifier)
        .refreshable { await onRefresh() }
        .overlay { if showsProgress { CustomProgressView() } }
    }

    /// The rows form a single rounded card.
    private var rows: some View {
        LazyVStack(spacing: 0) {
            ForEach(Array(accounts.enumerated()), id: \.offset) { _, account in
                Button {
                    guard !showsProgress, let id = account.id else { return }
                    onSelect(id)
                    isSearchFocused = false
                } label: {
                    AccountsListRowView(account: account, configuration: configuration)
                }
                .buttonStyle(.plain)
                .allowsHitTesting(!showsProgress)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: DesignSystem.shared.cornerRadius.large))
    }
}
