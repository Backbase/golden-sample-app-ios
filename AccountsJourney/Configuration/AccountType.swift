//
//  AccountType.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 07/11/2023.
//

import Foundation

extension AccountsJourney {
    /// All the account/product types
    public enum AccountType: String, CaseIterable {
        /// Current account
        case current = "current-account"
        /// Savings account
        case savings = "savings-account"
        /// Term deposit
        case termDeposit = "term-deposit"
        /// Loan product
        case loan
        /// Credit card
        case creditCard = "credit-card"
        /// Debit card
        case debitCard = "debit-card"
        /// Investment account
        case investment = "investment-account"
        /// General account / product
        case general
    }
}
