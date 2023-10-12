//
//  AggregatedBalance.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 11/10/2023.
//

import Foundation

struct AggregatedBalance: Equatable {
    let currency: String?
    let value: String?
    let productKindAggregatedBalanceItem: [ProductKindAggregatedBalanceItem]?
    let additions: [String: String]?
    
    init(
        currency: String?,
        value: String?,
        productKindAggregatedBalanceItem: [ProductKindAggregatedBalanceItem]? = nil,
        additions: [String : String]?
    ) {
        self.currency = currency
        self.value = value
        self.productKindAggregatedBalanceItem = productKindAggregatedBalanceItem
        self.additions = additions
    }
}
