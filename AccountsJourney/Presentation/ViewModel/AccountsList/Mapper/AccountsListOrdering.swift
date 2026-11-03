//
//  AccountsListOrdering.swift
//  AccountsJourney
//

import Foundation

/// Arranges the accounts of an `AccountSummaryData` for the accounts list.
enum AccountsListOrdering {

    /// The accounts of every kind in one list: current accounts, savings, term deposits, loans, credit
    /// cards, debit cards and investment accounts, in that order, then the custom products.
    static func orderedAccounts(from summary: AccountSummaryData) -> [AccountData] {
        let kinds = [
            summary.currentAccounts,
            summary.savingAccounts,
            summary.termDeposits,
            summary.loans,
            summary.creditCards,
            summary.debitCards,
            summary.investmentAccounts
        ]
        return (kinds.compactMap { $0 } + (summary.customProducts ?? [])).flatMap(\.products)
    }
}
