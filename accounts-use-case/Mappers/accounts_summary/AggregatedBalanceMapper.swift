//
//  AggregatedBalanceMapper.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 12/10/2023.
//

import Foundation
import AccountsJourney
import ArrangementsClient2Gen2

extension ArrangementsClient2Gen2.SummaryAggregatedBalance {
    public func toDomainModel() -> AccountsJourney.AggregatedBalance {
        AccountsJourney.AggregatedBalance(
            currency: self.currency,
            value: self.value,
            productKindAggregatedBalanceItem: nil,
            additions: self.additions
        )
    }
}
