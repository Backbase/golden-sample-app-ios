//
//  AccountDetailsHeaderContent.swift
//  AccountsJourney
//

import Foundation

/// The texts and the icon shown by `AccountDetailsHeaderView`.
///
/// A plain data type: the view model creates it, already formatted and localised, and the view only reads it.
struct AccountDetailsHeaderContent: Equatable {

    let icon: AccountIconInfo?
    let title: String
    let subtitle: String
    let balance: String
    let limit: String
}
