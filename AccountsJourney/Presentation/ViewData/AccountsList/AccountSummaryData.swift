//
//  AccountSummaryData.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 26/10/2023.
//

import Foundation

/// The accounts of the summary, grouped by the kind of product.
struct AccountSummaryData {
    var customProducts: [AccountsData]?
    var currentAccounts: AccountsData?
    var savingAccounts: AccountsData?
    var termDeposits: AccountsData?
    var loans: AccountsData?
    var creditCards: AccountsData?
    var debitCards: AccountsData?
    var investmentAccounts: AccountsData?
    
    init(customProducts: [AccountsData]? = nil, 
         currentAccounts: AccountsData? = nil,
         savingAccounts: AccountsData? = nil,
         termDeposits: AccountsData? = nil,
         loans: AccountsData? = nil,
         creditCards: AccountsData? = nil,
         debitCards: AccountsData? = nil,
         investmentAccounts: AccountsData? = nil) {
        self.customProducts = customProducts
        self.currentAccounts = currentAccounts
        self.savingAccounts = savingAccounts
        self.termDeposits = termDeposits
        self.loans = loans
        self.creditCards = creditCards
        self.debitCards = debitCards
        self.investmentAccounts = investmentAccounts
    }
}
