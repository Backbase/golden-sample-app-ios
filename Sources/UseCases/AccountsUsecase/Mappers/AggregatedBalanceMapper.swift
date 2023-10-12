//
//  AggregatedBalanceMapper.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 12/10/2023.
//

import Foundation
import ArrangementsClient2Gen2

extension ArrangementsClient2Gen2.SummaryAggregatedBalance {
    func toDomainModel() -> AggregatedBalance {
        AggregatedBalance(
            currency: self.currency,
            value: self.value,
            productKindAggregatedBalanceItem: nil,
            additions: self.additions
        )
    }
}
