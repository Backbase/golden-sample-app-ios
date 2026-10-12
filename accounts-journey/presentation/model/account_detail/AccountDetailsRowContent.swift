//
//  AccountDetailsRowContent.swift
//  AccountsJourney
//

import Foundation

/// The texts shown by `AccountDetailsRowView`. Same rules as the rows the UIKit
/// `AccountDetailsViewController` passes to `AccountDetailsUsageRowView`, expressed as plain `String`s.
struct AccountDetailsRowContent: Equatable {

    let title: String
    let subtitle: String

    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
}

// MARK: - Sections

extension AccountDetailsRowContent {

    /// Rows of the first (untitled) section: holder names and card or account number.
    static func detailsRows(
        for details: AccountDetailsUIModel,
        strings: AccountDetails.Strings
    ) -> [AccountDetailsRowContent] {
        [
            AccountDetailsRowContent(title: strings.holderNamesTitle(), subtitle: details.displayName),
            AccountDetailsRowContent(title: strings.cardOrAccountNumberTitle(), subtitle: details.BBAN)
        ]
    }

    /// Rows of the "General" section: account type and account name.
    static func generalRows(
        for details: AccountDetailsUIModel,
        strings: AccountDetails.Strings
    ) -> [AccountDetailsRowContent] {
        [
            AccountDetailsRowContent(title: strings.accountTypeTitle(), subtitle: details.productKindName),
            AccountDetailsRowContent(title: strings.accountNameTitle(), subtitle: details.productKindName)
        ]
    }

    /// Rows of the "Status" section: account status.
    static func statusRows(
        for details: AccountDetailsUIModel,
        strings: AccountDetails.Strings
    ) -> [AccountDetailsRowContent] {
        [
            AccountDetailsRowContent(title: strings.accountStatusTitle(), subtitle: details.accountState ?? "")
        ]
    }
}
