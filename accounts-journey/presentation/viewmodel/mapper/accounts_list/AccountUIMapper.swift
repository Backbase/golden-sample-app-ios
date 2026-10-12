//
//  AccountUIMapper.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 03/11/2023.
//

import Foundation
import BackbaseDesignSystem
import ArrangementsClient2Gen2

extension ProductSummary {

    func toMapUI(configuration: AccountsJourney.Configuration) -> AccountSummaryUIModel {
        
        var accountSummaryUIModel = AccountSummaryUIModel()
        if !customProductKinds.isEmpty {
            accountSummaryUIModel.customProducts =  customProductKinds.map {
                $0.mapToUi(configuration: configuration)
            }
        }
        if let currentAccounts {
            accountSummaryUIModel.currentAccounts = currentAccounts.mapToUi(configuration: configuration)
        }
        if let savingsAccounts {
            accountSummaryUIModel.savingAccounts = savingsAccounts.mapToUi(configuration: configuration)
        }
        if let termDeposits {
            accountSummaryUIModel.termDeposits = termDeposits.mapToUi(configuration: configuration)
        }
        if let loans {
            accountSummaryUIModel.loans = loans.mapToUi(configuration: configuration)
        }
        if let creditCards {
            accountSummaryUIModel.creditCards = creditCards.mapToUi(configuration: configuration)
        }
        if let debitCards {
            accountSummaryUIModel.debitCards = debitCards.mapToUi(configuration: configuration)
        }
        if let investmentAccounts {
            accountSummaryUIModel.investmentAccounts = investmentAccounts.mapToUi(configuration: configuration)
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
