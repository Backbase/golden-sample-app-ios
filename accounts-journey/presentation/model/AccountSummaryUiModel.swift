//
//  AccountSummaryUiModel.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 26/10/2023.
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
    
    func generateList(query: String = "") -> [AccountUiModel] {
        var result = [AccountUiModel]()
        
        result.append(contentsOf: filter(currentAccounts?.products, by: query))
        result.append(contentsOf: filter(savingAccounts?.products, by: query))
        result.append(contentsOf: filter(termDeposits?.products, by: query))
        result.append(contentsOf: filter(loans?.products, by: query))
        result.append(contentsOf: filter(creditCards?.products, by: query))
        result.append(contentsOf: filter(debitCards?.products, by: query))
        result.append(
            contentsOf: filter(
                investmentAccounts?.products,
                by: query)
        )
        
        customProducts?.forEach {
            result.append(contentsOf: filter($0.products, by: query))
        }
        return result
    }
    
    func filter(_
        products: [AccountUiModel]?,
        by query: String
    ) -> [AccountUiModel] {
        let q = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        if let products {
            return q.isEmpty ? products : products.filter { $0.name!.lowercased().contains(q) }
        }
        
        return []
    }
}
