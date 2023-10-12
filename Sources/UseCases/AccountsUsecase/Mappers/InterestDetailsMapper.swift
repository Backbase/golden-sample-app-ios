//
//  InterestDetailsMapper.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 12/10/2023.
//

import Foundation
import ArrangementsClient2Gen2

extension ArrangementsClient2Gen2.InterestDetails {
    func toDomainModel() -> InterestDetails {
        InterestDetails(
            additions: self.additions,
            lastYearAccruedInterest: self.lastYearAccruedInterest,
            dividendWithheldYTD: self.dividendWithheldYTD,
            annualPercentageYield: self.annualPercentageYield,
            cashAdvanceInterestRate: self.cashAdvanceInterestRate,
            penaltyInterestRate: self.penaltyInterestRate
        )
    }
}
