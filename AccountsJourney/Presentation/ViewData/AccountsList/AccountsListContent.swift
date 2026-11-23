//
//  AccountsListContent.swift
//  AccountsJourney
//

import Foundation

/// What `AccountsListContentView` shows once the accounts have loaded.
///
/// A plain data type: the view model creates it, already formatted and localised, and the view only reads it.
struct AccountsListContent: Equatable {

    /// The accounts matching the last submitted search, in display order.
    let rows: [AccountsListRowContent]
    /// `true` while a new load is in flight. The rows stay on screen until it answers, so the search
    /// field is not torn down in the middle of typing and a pull to refresh has something to refresh.
    var isReloading = false

    /// The search has been performed and there is nothing to show.
    var isEmpty: Bool {
        !isReloading && rows.isEmpty
    }
}
