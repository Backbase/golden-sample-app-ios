//
//  AccountDetailsSectionContent.swift
//  AccountsJourney
//

import Foundation

/// The texts shown by `AccountDetailsSectionView`: an optional title and the rows of the card.
///
/// A plain data type: the view model creates it, already localised, and the view only reads it.
struct AccountDetailsSectionContent: Equatable {

    let title: String?
    let rows: [AccountDetailsRowContent]

    init(title: String? = nil, rows: [AccountDetailsRowContent]) {
        self.title = title
        self.rows = rows
    }
}
