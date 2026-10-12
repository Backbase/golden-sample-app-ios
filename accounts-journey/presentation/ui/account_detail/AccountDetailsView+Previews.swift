//
//  AccountDetailsView+Previews.swift
//  AccountsJourney
//

import BackbaseDesignSystem
import SwiftUI

// MARK: - Previews

#if DEBUG
enum AccountDetailsPreviewData {

    static let details = AccountDetailsUIModel(
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
}

struct AccountDetailsPreview: View {

    var details: AccountDetailsUIModel?
    var isLoading = false
    var error: AccountDetails.Error?

    var body: some View {
        NavigationStack {
            AccountDetailsContentView(
                configuration: AccountsJourney.Configuration(),
                details: details,
                isLoading: isLoading,
                error: error,
                onRetry: {}
            )
            .background(Color(Theme.colors.background.page).ignoresSafeArea())
            .navigationTitle("Account details")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview("Loaded") {
    AccountDetailsPreview(details: AccountDetailsPreviewData.details)
}

#Preview("Loading") {
    AccountDetailsPreview(isLoading: true)
}

#Preview("Error") {
    AccountDetailsPreview(error: .loadingFailure())
}
#endif
