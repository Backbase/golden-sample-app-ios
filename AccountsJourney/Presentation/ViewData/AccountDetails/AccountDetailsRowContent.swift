//
//  AccountDetailsRowContent.swift
//  AccountsJourney
//

import Foundation

/// The texts shown by `AccountDetailsRowView`.
///
/// A plain data type: the view model creates it, already localised, and the view only reads it.
struct AccountDetailsRowContent: Equatable {

    let title: String
    let subtitle: String
}
