//
//  AccountsListContentView.swift
//  AccountsJourney
//

import BackbaseDesignSystem
import SwiftUI

/// The screen for a given state. It knows nothing about the view model, which keeps it previewable.
struct AccountsListContentView: View {

    let configuration: AccountsJourney.Configuration
    let rows: [AccountsListRowContent]
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
                configuration: error.stateViewConfiguration(using: configuration, primaryAction: onRetry),
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
        !rows.isEmpty || !searchText.isEmpty
    }

    private var showsEmptyState: Bool {
        !isLoading && rows.isEmpty
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
                            using: configuration,
                            primaryAction: onRetry
                        ),
                        appearance: EmblemAppearance.appearance(for: Color(Theme.colors.background.neutralSubtle)),
                        accessibilityIdentifier: Self.stateViewIdentifier
                    )
                    .padding(.top, DesignSystem.shared.sizer.xl)
                } else {
                    rowsCard
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
    private var rowsCard: some View {
        LazyVStack(spacing: 0) {
            ForEach(Array(rows.enumerated()), id: \.offset) { _, row in
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
