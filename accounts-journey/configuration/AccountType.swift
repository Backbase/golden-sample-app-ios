//
//  AccountType.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 07/11/2023.
//

import Foundation

extension AccountsJourney {
    enum AccountType: CaseIterable {
        case current
        case savings
        case termDeposit
        case loan
        case creditCard
        case debitCard
        case investment
        case general
    }
}
