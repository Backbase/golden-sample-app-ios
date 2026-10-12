//
//  AccountsListView.swift
//  AccountsJourney
//

import BackbaseDesignSystem
import BackbaseObservability
import Combine
import Resolver
import SwiftUI

/// SwiftUI replacement of `AccountsListViewController`.
///
/// Shares `AccountsListViewModel` with the UIKit screen. This view owns what is specific to
/// SwiftUI: the search text (debounced into `.search` events), pull to refresh and the
/// analytics subjects the view model binds to.
struct AccountsListView: View {

    @ObservedObject private var viewModel: AccountsListViewModel
    private let configuration: AccountsJourney.Configuration

    @State private var searchText = ""
    @State private var lastSubmittedQuery = ""
    @State private var isPullRefreshing = false
    @State private var hasStarted = false
    @State private var viewDidAppearSubject = PassthroughSubject<Void, Never>()
    @State private var userActionEventSubject = PassthroughSubject<UserActionEvent, Never>()

    private static let searchDebounce: Duration = .milliseconds(500)

    init(
        viewModel: AccountsListViewModel,
        configuration: AccountsJourney.Configuration = Resolver.resolve()
    ) {
        self.viewModel = viewModel
        self.configuration = configuration
    }

    var body: some View {
        AccountsListContentView(
            accounts: viewModel.allAccounts,
            state: viewModel.screenState,
            searchText: $searchText,
            isRefreshing: isPullRefreshing,
            onSelect: { viewModel.didSelectProduct?($0) },
            onRefresh: refresh
        )
        .background(Color(Theme.colors.background.page).ignoresSafeArea())
        .navigationTitle(configuration.accountsList.strings.screenTitle())
        .navigationBarTitleDisplayMode(.large)
        .onAppear(perform: onAppear)
        .task(id: searchText) { await submitSearch() }
        .onChange(of: viewModel.screenState.isError) { _, isError in
            // The list, and with it the search field, is replaced by the error state.
            if isError { resetSearch() }
        }
    }

    // MARK: - Private

    private func onAppear() {
        if !hasStarted {
            hasStarted = true
            viewModel.bind(
                viewDidAppearPublisher: viewDidAppearSubject.eraseToAnyPublisher(),
                userActionEventPublisher: userActionEventSubject.eraseToAnyPublisher()
            )
            viewModel.onEvent(.getAccounts)
        }
        viewDidAppearSubject.send()
    }

    /// Debounces the typed text. `task(id:)` cancels the pending sleep on every keystroke.
    private func submitSearch() async {
        guard searchText != lastSubmittedQuery else { return }
        try? await Task.sleep(for: Self.searchDebounce)
        guard !Task.isCancelled else { return }
        lastSubmittedQuery = searchText
        viewModel.onEvent(.search(searchText))
    }

    private func refresh() async {
        isPullRefreshing = true
        defer { isPullRefreshing = false }
        // A refresh loads the unfiltered list, so the field must not keep a stale query.
        resetSearch()
        userActionEventSubject.send(UserActionEvent(.refreshAccounts))
        await viewModel.refreshAccounts()
    }

    private func resetSearch() {
        searchText = ""
        lastSubmittedQuery = ""
    }
}

// MARK: - Content

/// The screen for a given state. It knows nothing about the view model, which keeps it previewable.
private struct AccountsListContentView: View {

    let accounts: [AccountUIModel]
    let state: AccountListScreenState
    @Binding var searchText: String
    let isRefreshing: Bool
    let onSelect: (String) -> Void
    let onRefresh: () async -> Void

    private static let stateViewIdentifier = "AccountsListStateView"

    /// Owned here, not by the search bar, so a row tap can dismiss the keyboard.
    @FocusState private var isSearchFocused: Bool

    var body: some View {
        switch state {
        case let .hasError(stateConfiguration):
            StateConfigurationView(
                configuration: stateConfiguration,
                appearance: EmblemAppearance.appearance(for: Color(Theme.colors.background.dangerSubtle)),
                accessibilityIdentifier: Self.stateViewIdentifier
            )
            .padding(.horizontal, DesignSystem.shared.spacer.md)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        default:
            list
        }
    }

    /// Hidden until there is something to search, and kept while a search has no results so
    /// the query can still be edited.
    private var showsSearchBar: Bool {
        !accounts.isEmpty || !searchText.isEmpty
    }

    private var list: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                if showsSearchBar {
                    AccountsSearchBarView(text: $searchText, isFocused: $isSearchFocused)
                }
                if case let .emptyResults(stateConfiguration) = state {
                    StateConfigurationView(
                        configuration: stateConfiguration,
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
        .refreshable { await onRefresh() }
        .overlay { if showsProgress { CustomProgressView() } }
    }

    private var showsProgress: Bool {
        state.isLoading && !isRefreshing
    }

    private var rows: some View {
        ForEach(Array(accounts.enumerated()), id: \.offset) { index, account in
            Button {
                guard !showsProgress, let id = account.id else { return }
                onSelect(id)
                isSearchFocused = false
            } label: {
                AccountsListRowView(
                    account: account,
                    position: .position(forRow: index, count: accounts.count)
                )
            }
            .buttonStyle(.plain)
            .allowsHitTesting(!showsProgress)
        }
    }
}

// MARK: - Previews

#if DEBUG
private enum AccountsListPreviewData {

    static let accounts: [AccountUIModel] = [
        AccountUIModel(
            id: "1",
            name: "Main account",
            balance: Currency(amount: "1250.50", currencyCode: "EUR"),
            state: "Active",
            iconName: AccountIconInfo(
                icon: UIImage(systemName: "creditcard") ?? UIImage(),
                backgroundColor: Theme.colors.background.brandSubtle
            )
        ),
        AccountUIModel(
            id: "2",
            name: "Savings",
            balance: Currency(amount: "9800", currencyCode: "EUR"),
            state: "Inactive",
            iconName: AccountIconInfo(
                icon: UIImage(systemName: "banknote") ?? UIImage(),
                backgroundColor: Theme.colors.background.successSubtle
            )
        ),
        AccountUIModel(
            id: "3",
            name: "Loan",
            balance: Currency(amount: "-12000", currencyCode: "EUR"),
            state: "Closed",
            iconName: AccountIconInfo(
                icon: UIImage(systemName: "percent") ?? UIImage(),
                backgroundColor: Theme.colors.background.category2Subtle
            )
        )
    ]

    static func stateConfiguration(
        icon: String,
        title: String,
        subtitle: String,
        button: String? = nil
    ) -> StateViewConfiguration {
        GenericStateViewConfiguration(
            iconName: icon,
            title: title,
            subtitle: subtitle,
            firstButtonConfiguration: button.map { ButtonConfiguration(title: $0, action: {}) }
        )
    }
}

private struct AccountsListPreview: View {

    let accounts: [AccountUIModel]
    let state: AccountListScreenState
    @State var searchText = ""

    var body: some View {
        NavigationStack {
            AccountsListContentView(
                accounts: accounts,
                state: state,
                searchText: $searchText,
                isRefreshing: false,
                onSelect: { _ in },
                onRefresh: {}
            )
            .background(Color(Theme.colors.background.page).ignoresSafeArea())
            .navigationTitle("Accounts")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview("Loaded") {
    Resolver.register { AccountsJourney.Configuration() }
    return AccountsListPreview(accounts: AccountsListPreviewData.accounts, state: .loaded)
}

#Preview("Loading") {
    Resolver.register { AccountsJourney.Configuration() }
    return AccountsListPreview(accounts: [], state: .loading)
}

#Preview("No results") {
    Resolver.register { AccountsJourney.Configuration() }
    return AccountsListPreview(
        accounts: [],
        state: .emptyResults(
            AccountsListPreviewData.stateConfiguration(
                icon: DesignSystem.Assets.icStateViewNoWifi,
                title: "No accounts",
                subtitle: "There are no accounts to show."
            )
        ),
        searchText: "xyz"
    )
}

#Preview("Error") {
    Resolver.register { AccountsJourney.Configuration() }
    return AccountsListPreview(
        accounts: [],
        state: .hasError(
            AccountsListPreviewData.stateConfiguration(
                icon: DesignSystem.Assets.icStateViewLoadingFailed,
                title: "Something went wrong",
                subtitle: "We couldn't load your accounts.",
                button: "Try again"
            )
        )
    )
}
#endif
