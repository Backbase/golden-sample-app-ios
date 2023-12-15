//
//  TermUnitMapper.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 12/10/2023.
//

import Foundation
import AccountsJourney
import ArrangementsClient2Gen2

extension ArrangementsClient2Gen2.TimeUnit {
    public func toDomainModel() -> AccountsJourney.TimeUnit {
        switch self {
        case .d:
            return .day
        case .m:
            return .month
        case .w:
            return .week
        case .y:
            return .year
        default:
            return .day
        }
    }
}
