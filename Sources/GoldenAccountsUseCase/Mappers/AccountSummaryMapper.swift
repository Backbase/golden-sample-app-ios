//
//  AccountSummaryMapper.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 12/10/2023.
//

import Foundation
import AccountsJourney
import ArrangementsClient2Gen2

extension ArrangementsClient2Gen2.ProductSummary {
    func toDomainModel() -> AccountsJourney.AccountsSummary {
        AccountsJourney.AccountsSummary(
            customProducts:
                self.customProductKinds.map { $0.toDomainModel() },
            aggregatedBalance: 
                self.aggregatedBalance?.toDomainModel(),
            currentAccounts: 
                self.currentAccounts?.toDomainModel(),
            savingsAccounts: 
                self.savingsAccounts?.toDomainModel(),
            termDeposits: 
                self.termDeposits?.toDomainModel(),
            loans: 
                self.loans?.toDomainModel(),
            creditCards: 
                self.creditCards?.toDomainModel(),
            debitCards: 
                self.debitCards?.toDomainModel(),
            investmentAccounts: 
                self.investmentAccounts?.toDomainModel(),
            additions: 
                self.additions
        )
    }
}
