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
    
    func generateList(query: String = "") -> [AccountUiModel] {
        var result = [AccountUiModel]()
        
        result.append(contentsOf: filter(
            accounts: currentAccounts?.products, query: query))
        result.append(contentsOf: filter(
            accounts: savingAccounts?.products, query: query))
        result.append(contentsOf: filter(
            accounts: termDeposits?.products, query: query))
        result.append(contentsOf: filter(
            accounts: loans?.products, query: query))
        result.append(contentsOf: filter(
            accounts: creditCards?.products, query: query))
        result.append(contentsOf: filter(
            accounts: debitCards?.products, query: query))
        result.append(contentsOf: filter(
            accounts: investmentAccounts?.products, query: query))
        customProducts?.forEach {
            result.append(contentsOf: filter(accounts: $0.products, query: query))
        }
        
        return result
    }
    
    private func filter(accounts: [AccountUiModel]?, query: String) -> [AccountUiModel] {
        let q = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        if let accounts {
            return q.isEmpty ? accounts : accounts.filter { $0.name!.lowercased().contains(q) }
        }
        
        return []
    }
}
