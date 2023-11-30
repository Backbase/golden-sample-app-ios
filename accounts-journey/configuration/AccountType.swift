//
//  AccountType.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 07/11/2023.
//

import Foundation

extension AccountsJourney {
    public enum AccountType: String, CaseIterable {
        case current = "current-account"
        case savings = "savings-account"
        case termDeposit = "term-deposit"
        case loan
        case creditCard = "credit-card"
        case debitCard = "debit-card"
        case investment = "investment-account"
        case general
    }
}
