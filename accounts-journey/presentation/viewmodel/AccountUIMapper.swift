//
//  AccountUIMapper.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 03/11/2023.
//

import Foundation
import BackbaseDesignSystem
import Resolver

extension AccountsJourney.AccountsSummary {
    
    func toMapUI() -> AccountSummaryUIModel {
        
        var accountSummaryUIModel = AccountSummaryUIModel()
        if !self.customProducts.isEmpty {
            accountSummaryUIModel.customProducts =  self.customProducts.map {
                $0.mapToUi()
            }
        }
        if let currentAccounts = self.currentAccounts {
            accountSummaryUIModel.currentAccounts = currentAccounts.mapToUi()
        }
        if let savingsAccounts = self.savingsAccounts {
            accountSummaryUIModel.savingAccounts = savingsAccounts.mapToUi()
        }
        if let termDeposits = self.termDeposits {
            accountSummaryUIModel.termDeposits = termDeposits.mapToUi()
        }
        if let loans = self.loans {
            accountSummaryUIModel.loans = loans.mapToUi()
        }
        if let creditCards = self.creditCards {
            accountSummaryUIModel.creditCards = creditCards.mapToUi()
        }
        if let debitCards = self.debitCards {
            accountSummaryUIModel.debitCards = debitCards.mapToUi()
        }
        if let investmentAccounts = self.investmentAccounts {
            accountSummaryUIModel.investmentAccounts = investmentAccounts.mapToUi()
        }
        
        return accountSummaryUIModel
    }
}
func formatState(_ productState: AccountsJourney.ProductState?, number: String?) -> String? {
    if let state = productState?.state, let number {
        if state == "Active" {
            return number
        } else {
            return state
        }
    }
    return number ?? nil
}



