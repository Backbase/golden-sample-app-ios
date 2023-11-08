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
    
    func generateList(query: String = "") -> [AccountsUiModel] {
        var result = [AccountsUiModel]()
        
        result.append(contentsOf: filter(accounts: currentAccounts, query: query))
        result.append(contentsOf: filter(accounts: savingAccounts, query: query))
        result.append(contentsOf: filter(accounts: termDeposits, query: query))
        result.append(contentsOf: filter(accounts: loans, query: query))
        result.append(contentsOf: filter(accounts: creditCards, query: query))
        result.append(contentsOf: filter(accounts: debitCards, query: query))
        result.append(contentsOf: filter(accounts: investmentAccounts, query: query))
        customProducts?.forEach {
            result.append(contentsOf: filter(accounts: $0, query: query))
        }
        
        return result
    }
    
    private func filter(accounts: AccountsUiModel?, query: String) -> [AccountsUiModel] {
        let q = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        if let accounts {
            let products = q.isEmpty ? accounts.products : accounts.products.filter { $0.name!.lowercased().contains(q) }
            let accountsUIModel = AccountsUiModel(header: accounts.header, products: products)
            return [accountsUIModel]
        }
        
        return []
    }
}
