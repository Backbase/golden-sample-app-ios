//
//  AccountSummaryUIModel.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 26/10/2023.
//

import Foundation

struct AccountSummaryUIModel {
    var customProducts: [AccountsUIModel]?
    var currentAccounts: AccountsUIModel?
    var savingAccounts: AccountsUIModel?
    var termDeposits: AccountsUIModel?
    var loans: AccountsUIModel?
    var creditCards: AccountsUIModel?
    var debitCards: AccountsUIModel?
    var investmentAccounts: AccountsUIModel?
    
    init(customProducts: [AccountsUIModel]? = nil, 
         currentAccounts: AccountsUIModel? = nil,
         savingAccounts: AccountsUIModel? = nil,
         termDeposits: AccountsUIModel? = nil,
         loans: AccountsUIModel? = nil,
         creditCards: AccountsUIModel? = nil,
         debitCards: AccountsUIModel? = nil,
         investmentAccounts: AccountsUIModel? = nil) {
        self.customProducts = customProducts
        self.currentAccounts = currentAccounts
        self.savingAccounts = savingAccounts
        self.termDeposits = termDeposits
        self.loans = loans
        self.creditCards = creditCards
        self.debitCards = debitCards
        self.investmentAccounts = investmentAccounts
    }
    
    func generateList(query: String = "") -> [AccountUIModel] {
        var result = [AccountUIModel]()
        
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
    
    func filter(_ products: [AccountUIModel]?, by query: String
    ) -> [AccountUIModel] {
        let searchQuery = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        if let products {
            return searchQuery.isEmpty ? products : products.filter { $0.name!.lowercased().contains(searchQuery) }
        }
        
        return []
    }
}
