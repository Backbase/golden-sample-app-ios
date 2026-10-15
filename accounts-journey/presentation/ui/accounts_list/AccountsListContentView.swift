//
//  AccountsListContentView.swift
//  AccountsJourney
//

import BackbaseDesignSystem
import SwiftUI

/// The screen for a given state. It knows nothing about the view model, which keeps it previewable.
struct AccountsListContentView: View {

    let configuration: AccountsJourney.Configuration
    let state: ViewState<AccountsListContent>
    @Binding var searchText: String
    let isRefreshing: Bool
    let onSelect: (String) -> Void
    let onRefresh: () async -> Void
    /// What the empty state's button runs. The error state has its own retry, in its configuration.
    let onRetry: () -> Void

    private static let stateViewIdentifier = "AccountsListStateView"
    private static let scrollViewIdentifier = "AccountsListScrollView"

    /// Owned here, not by the search bar, so a row tap can dismiss the keyboard.
    @FocusState private var isSearchFocused: Bool

    var body: some View {
        ViewStateContainer(
            state: state,
            errorAppearance: EmblemAppearance.appearance(for: Color(Theme.colors.background.dangerSubtle)),
            errorAccessibilityIdentifier: Self.stateViewIdentifier
        ) { content in
            list(for: content)
        }
    }

    /// Hidden until there is something to search, and kept while a search has no results so
    /// the query can still be edited.
    private func showsSearchBar(for content: AccountsListContent) -> Bool {
        !content.rows.isEmpty || !searchText.isEmpty
    }

    /// The pull to refresh indicator is the progress of a pull to refresh.
    private func showsProgress(for content: AccountsListContent) -> Bool {
        content.isReloading && !isRefreshing
    }

    private func list(for content: AccountsListContent) -> some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                if showsSearchBar(for: content) {
                    AccountsSearchBarView(text: $searchText, isFocused: $isSearchFocused, configuration: configuration)
                }
                if content.isEmpty {
                    StateConfigurationView(
                        configuration: AccountsListErrorConfigurationMapper(journeyConfiguration: configuration)
                            .stateViewConfiguration(for: .noAccounts, retry: onRetry),
                        appearance: EmblemAppearance.appearance(for: Color(Theme.colors.background.neutralSubtle)),
                        accessibilityIdentifier: Self.stateViewIdentifier
                    )
                    .padding(.top, DesignSystem.shared.sizer.xl)
                } else {
                    rowsCard(for: content)
                }
            }
            .padding(DesignSystem.shared.spacer.md)
        }
        .scrollIndicators(.hidden)
        .scrollDismissesKeyboard(.immediately)
        .accessibilityIdentifier(Self.scrollViewIdentifier)
        .refreshable { await onRefresh() }
        .overlay { if showsProgress(for: content) { CustomProgressView() } }
    }

    /// The rows form a single rounded card.
    private func rowsCard(for content: AccountsListContent) -> some View {
        let showsProgress = showsProgress(for: content)
        return LazyVStack(spacing: 0) {
            ForEach(Array(content.rows.enumerated()), id: \.offset) { _, row in
                Button {
                    guard !showsProgress, let id = row.id else { return }
                    onSelect(id)
                    isSearchFocused = false
                } label: {
                    AccountsListRowView(content: row)
                }
                .buttonStyle(.plain)
                .allowsHitTesting(!showsProgress)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: DesignSystem.shared.cornerRadius.large))
    }
}
