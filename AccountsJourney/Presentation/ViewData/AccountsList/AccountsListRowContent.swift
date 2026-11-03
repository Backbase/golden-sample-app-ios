//
//  AccountsListRowContent.swift
//  AccountsJourney
//

import Foundation

/// What `AccountsListRowView` shows for one account.
///
/// A plain data type: the view model creates it, already formatted and localised, and the view only reads it.
struct AccountsListRowContent: Equatable {

    /// The id of the account the row stands for, if it has one.
    let id: String?
    let icon: AccountIconInfo?
    let name: String
    let state: String?
    let balance: String?
}
