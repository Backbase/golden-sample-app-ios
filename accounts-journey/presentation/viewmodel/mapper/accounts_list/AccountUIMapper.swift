//
//  AccountUIMapper.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 03/11/2023.
//

import Foundation
import BackbaseDesignSystem
import Resolver
import ArrangementsClient2Gen2

extension ProductSummary {

    func toMapUI() -> AccountSummaryUIModel {
        
        var accountSummaryUIModel = AccountSummaryUIModel()
        if !customProductKinds.isEmpty {
            accountSummaryUIModel.customProducts =  customProductKinds.map {
                $0.mapToUi()
            }
        }
        if let currentAccounts {
            accountSummaryUIModel.currentAccounts = currentAccounts.mapToUi()
        }
        if let savingsAccounts {
            accountSummaryUIModel.savingAccounts = savingsAccounts.mapToUi()
        }
        if let termDeposits {
            accountSummaryUIModel.termDeposits = termDeposits.mapToUi()
        }
        if let loans {
            accountSummaryUIModel.loans = loans.mapToUi()
        }
        if let creditCards {
            accountSummaryUIModel.creditCards = creditCards.mapToUi()
        }
        if let debitCards {
            accountSummaryUIModel.debitCards = debitCards.mapToUi()
        }
        if let investmentAccounts {
            accountSummaryUIModel.investmentAccounts = investmentAccounts.mapToUi()
        }
        
        return accountSummaryUIModel
    }
}

func formatState(_ productState: ArrangementsClient2Gen2.StateItem?, number: String?) -> String? {
    if let state = productState?.state, let number {
        if state == "Active" {
            return number
        } else {
            return state
        }
    }
    return number ?? nil
}
