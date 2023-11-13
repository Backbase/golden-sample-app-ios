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
    
    init(customProducts: [AccountsUiModel]? = nil, 
         currentAccounts: AccountsUiModel? = nil,
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
    
    func generateList() -> [AccountUiModel] {
        var result = [AccountUiModel]()
        
        if let currentAccountProducts = currentAccounts?.products {
            result.append(contentsOf: currentAccountProducts)
        }
        if let savingsAccountProducts = savingAccounts?.products {
            result.append(contentsOf: savingsAccountProducts)
        }
        if let termDepositProducts = termDeposits?.products {
            result.append(contentsOf: termDepositProducts)
        }
        if let loanProducts = loans?.products {
            result.append(contentsOf: loanProducts)
        }
        if let creditCardsProducts = creditCards?.products {
            result.append(contentsOf: creditCardsProducts)
        }
        if let debitCardsProducts = debitCards?.products {
            result.append(contentsOf: debitCardsProducts)
        }
        if let investmentAccountsProducts = investmentAccounts?.products {
            result.append(contentsOf: investmentAccountsProducts)
        }
        
        customProducts?.forEach {
            result.append(contentsOf: $0.products)
        }
        return result
    }
}
