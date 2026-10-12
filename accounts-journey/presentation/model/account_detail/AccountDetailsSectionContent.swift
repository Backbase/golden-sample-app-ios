//
//  AccountDetailsSectionContent.swift
//  AccountsJourney
//

import Foundation

/// The texts shown by `AccountDetailsSectionView`: an optional title and the rows of the card.
struct AccountDetailsSectionContent: Equatable {

    let title: String?
    let rows: [AccountDetailsRowContent]

    init(title: String? = nil, rows: [AccountDetailsRowContent]) {
        self.title = title?.uppercased()
        self.rows = rows
    }
}

// MARK: - Sections

extension AccountDetailsSectionContent {

    /// First section: holder names and card or account number. It has a blank title, which keeps
    /// the same vertical spacing as the sections with a title.
    static func details(
        for details: AccountDetailsUIModel,
        strings: AccountDetails.Strings
    ) -> AccountDetailsSectionContent {
        AccountDetailsSectionContent(
            title: "",
            rows: AccountDetailsRowContent.detailsRows(for: details, strings: strings)
        )
    }

    /// "General" section: account type and account name.
    static func general(
        for details: AccountDetailsUIModel,
        strings: AccountDetails.Strings
    ) -> AccountDetailsSectionContent {
        AccountDetailsSectionContent(
            title: strings.generalSectionTitle(),
            rows: AccountDetailsRowContent.generalRows(for: details, strings: strings)
        )
    }

    /// "Status" section: account status.
    static func status(
        for details: AccountDetailsUIModel,
        strings: AccountDetails.Strings
    ) -> AccountDetailsSectionContent {
        AccountDetailsSectionContent(
            title: strings.statusSectionTitle(),
            rows: AccountDetailsRowContent.statusRows(for: details, strings: strings)
        )
    }
}
