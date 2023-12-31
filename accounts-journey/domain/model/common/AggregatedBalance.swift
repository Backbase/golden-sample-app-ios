//
//  AggregatedBalance.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 11/10/2023.
//

import Foundation

extension AccountsJourney {
    public struct AggregatedBalance: Equatable {
        public let currency: String?
        public let value: String?
        public let productKindAggregatedBalanceItem: [ProductKindAggregatedBalanceItem]?
        public let additions: [String: String]?
        
        public init(
            currency: String?,
            value: String?,
            productKindAggregatedBalanceItem: [ProductKindAggregatedBalanceItem]? = nil,
            additions: [String: String]?
        ) {
            self.currency = currency
            self.value = value
            self.productKindAggregatedBalanceItem = productKindAggregatedBalanceItem
            self.additions = additions
        }
    }
}
