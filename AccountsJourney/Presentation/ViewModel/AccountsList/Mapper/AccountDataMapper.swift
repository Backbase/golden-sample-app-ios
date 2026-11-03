//
//  AccountDataMapper.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 03/11/2023.
//

import Foundation
import BackbaseDesignSystem
import ArrangementsClient2Gen2

extension ProductSummary {

    func toMapUI(configuration: AccountsJourney.Configuration) -> AccountSummaryData {
        
        var accountSummaryData = AccountSummaryData()
        if !customProductKinds.isEmpty {
            accountSummaryData.customProducts =  customProductKinds.map {
                $0.mapToUi(configuration: configuration)
            }
        }
        if let currentAccounts {
            accountSummaryData.currentAccounts = currentAccounts.mapToUi(configuration: configuration)
        }
        if let savingsAccounts {
            accountSummaryData.savingAccounts = savingsAccounts.mapToUi(configuration: configuration)
        }
        if let termDeposits {
            accountSummaryData.termDeposits = termDeposits.mapToUi(configuration: configuration)
        }
        if let loans {
            accountSummaryData.loans = loans.mapToUi(configuration: configuration)
        }
        if let creditCards {
            accountSummaryData.creditCards = creditCards.mapToUi(configuration: configuration)
        }
        if let debitCards {
            accountSummaryData.debitCards = debitCards.mapToUi(configuration: configuration)
        }
        if let investmentAccounts {
            accountSummaryData.investmentAccounts = investmentAccounts.mapToUi(configuration: configuration)
        }
        
        return accountSummaryData
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
