//
//  InterestDetailsMapper.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 12/10/2023.
//

import Foundation
import AccountsJourney
import ArrangementsClient2Gen2

extension ArrangementsClient2Gen2.InterestDetails {
    func toDomainModel() -> AccountsJourney.InterestDetails {
        AccountsJourney.InterestDetails(
            additions: self.additions,
            lastYearAccruedInterest: self.lastYearAccruedInterest,
            dividendWithheldYTD: self.dividendWithheldYTD,
            annualPercentageYield: self.annualPercentageYield,
            cashAdvanceInterestRate: self.cashAdvanceInterestRate,
            penaltyInterestRate: self.penaltyInterestRate
        )
    }
}
