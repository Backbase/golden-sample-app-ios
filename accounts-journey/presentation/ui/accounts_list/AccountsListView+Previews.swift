//
//  AccountsListView+Previews.swift
//  AccountsJourney
//

import BackbaseDesignSystem
import SwiftUI

// MARK: - Previews

#if DEBUG
enum AccountsListPreviewData {

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
}

struct AccountsListPreview: View {

    let accounts: [AccountUIModel]
    var isLoading = false
    var error: AccountsList.Error?
    @State var searchText = ""

    var body: some View {
        NavigationStack {
            AccountsListContentView(
                configuration: AccountsJourney.Configuration(),
                accounts: accounts,
                isLoading: isLoading,
                error: error,
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
    AccountsListPreview(accounts: AccountsListPreviewData.accounts)
}

#Preview("Loading") {
    AccountsListPreview(accounts: [], isLoading: true)
}

#Preview("No results") {
    AccountsListPreview(accounts: [], searchText: "xyz")
}

#Preview("Error") {
    AccountsListPreview(accounts: [], error: .loadingFailure())
}
#endif
