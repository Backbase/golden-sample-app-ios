//
//  TermUnitMapper.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 12/10/2023.
//

import Foundation
import ArrangementsClient2Gen2

extension ArrangementsClient2Gen2.TimeUnit {
    func toDomainModel() -> TimeUnit {
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
