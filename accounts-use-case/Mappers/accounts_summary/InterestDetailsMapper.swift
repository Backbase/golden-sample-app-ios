//
//  InterestDetailsMapper.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 12/10/2023.
//

import Foundation
import AccountsJourney
import ArrangementsApi

extension ArrangementsApi.InterestDetails {
    public func toDomainModel() -> AccountsJourney.InterestDetails {
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
