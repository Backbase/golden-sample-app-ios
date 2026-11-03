//
//  AccountDetailsContent.swift
//  AccountsJourney
//

import Foundation

/// Everything the loaded account details screen shows: the header followed by the sections.
///
/// A plain data type: the view model creates it, already formatted and localised, and the view only reads it.
struct AccountDetailsContent: Equatable {

    let header: AccountDetailsHeaderContent
    let sections: [AccountDetailsSectionContent]
}
