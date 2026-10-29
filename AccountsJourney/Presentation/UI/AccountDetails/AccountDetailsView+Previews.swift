//
//  AccountDetailsView+Previews.swift
//  AccountsJourney
//

import BackbaseDesignSystem
import SwiftUI

// MARK: - Previews

#if DEBUG
enum AccountDetailsPreviewData {

    static let details = AccountDetailsData(
        id: "1",
        name: "Main account",
        displayName: "John Doe",
        BBAN: "****************0025",
        currency: "EUR",
        availableBalance: 3207.61,
        accountHolderNames: "John Doe",
        productKindName: "Current Account",
        productTypeName: "Current Account",
        bankBranchCode: nil,
        lastUpdateDate: "",
        accountInterestRate: nil,
        accruedInterest: 0,
        creditLimit: 1055.5,
        accountOpeningDate: "",
        accountState: "Active",
        iconName: AccountIconInfo(
            icon: UIImage(systemName: "creditcard") ?? UIImage(),
            backgroundColor: Theme.colors.background.brandSubtle
        )
    )

    static let content = AccountDetailsContentMapper(strings: AccountDetails.Strings()).content(for: details)
}

struct AccountDetailsPreview: View {

    var state: ViewState<AccountDetailsContent>

    var body: some View {
        NavigationStack {
            AccountDetailsContentView(state: state)
                .background(Color(Theme.colors.background.page).ignoresSafeArea())
                .navigationTitle("Account details")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview("Loaded") {
    AccountDetailsPreview(state: .loaded(AccountDetailsPreviewData.content))
}

#Preview("Loading") {
    AccountDetailsPreview(state: .loading)
}

#Preview("Error") {
    AccountDetailsPreview(
        state: .error(
            AccountDetailsErrorConfigurationMapper(journeyConfiguration: AccountsJourney.Configuration())
                .stateViewConfiguration(for: .loadingFailure(), retry: {})
        )
    )
}
#endif
