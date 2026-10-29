//
//  AccountsListView+Previews.swift
//  AccountsJourney
//

import BackbaseDesignSystem
import SwiftUI

// MARK: - Previews

#if DEBUG
enum AccountsListPreviewData {

    static let accounts: [AccountData] = [
        AccountData(
            id: "1",
            name: "Main account",
            balance: Currency(amount: "1250.50", currencyCode: "EUR"),
            state: "Active",
            iconName: AccountIconInfo(
                icon: UIImage(systemName: "creditcard") ?? UIImage(),
                backgroundColor: Theme.colors.background.brandSubtle
            )
        ),
        AccountData(
            id: "2",
            name: "Savings",
            balance: Currency(amount: "9800", currencyCode: "EUR"),
            state: "Inactive",
            iconName: AccountIconInfo(
                icon: UIImage(systemName: "banknote") ?? UIImage(),
                backgroundColor: Theme.colors.background.successSubtle
            )
        ),
        AccountData(
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

    static let rows = AccountsListContentMapper(strings: AccountsList.Strings()).rows(for: accounts)
}

struct AccountsListPreview: View {

    let state: ViewState<AccountsListContent>
    @State var searchText = ""

    var body: some View {
        NavigationStack {
            AccountsListContentView(
                configuration: AccountsJourney.Configuration(),
                state: state,
                searchText: $searchText,
                isRefreshing: false,
                onSelect: { _ in },
                onRefresh: {},
                onRetry: {}
            )
            .background(Color(Theme.colors.background.page).ignoresSafeArea())
            .navigationTitle("Accounts")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview("Loaded") {
    AccountsListPreview(state: .loaded(AccountsListContent(rows: AccountsListPreviewData.rows)))
}

#Preview("Loading") {
    AccountsListPreview(state: .loading)
}

#Preview("No results") {
    AccountsListPreview(state: .loaded(AccountsListContent(rows: [])), searchText: "xyz")
}

#Preview("Error") {
    AccountsListPreview(
        state: .error(
            AccountsListErrorConfigurationMapper(journeyConfiguration: AccountsJourney.Configuration())
                .stateViewConfiguration(for: .loadingFailure(), retry: {})
        )
    )
}
#endif
