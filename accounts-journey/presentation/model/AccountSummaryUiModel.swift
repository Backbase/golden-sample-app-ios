//
//  AccountSummaryUiModel.swift
//  AccountsJourney
//
//  Created by George Nyakundi on 26/10/2023.
//

import Foundation

struct AccountSummaryUiModel {
    var customProducts: [AccountsUiModel]?
    var currentAccounts: AccountsUiModel?
    var savingAccounts: AccountsUiModel?
    var termDeposits: AccountsUiModel?
    var loans: AccountsUiModel?
    var creditCards: AccountsUiModel?
    var debitCards: AccountsUiModel?
    var investmentAccounts: AccountsUiModel?
    
    init(customProducts: [AccountsUiModel]? = nil, currentAccounts: AccountsUiModel? = nil,
         savingAccounts: AccountsUiModel? = nil,
         termDeposits: AccountsUiModel? = nil,
         loans: AccountsUiModel? = nil,
         creditCards: AccountsUiModel? = nil,
         debitCards: AccountsUiModel? = nil,
         investmentAccounts: AccountsUiModel? = nil) {
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
