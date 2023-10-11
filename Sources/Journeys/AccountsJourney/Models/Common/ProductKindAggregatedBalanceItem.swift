//
//  ProductKindAggregatedBalanceItem.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 11/10/2023.
//

import Foundation

struct ProductKindAggregatedBalanceItem: Equatable {
    let amount: Double?
    let numberOfAccounts: Int?
    let productKindName: String?
    
    init(
        amount: Double?,
        numberOfAccounts: Int?,
        productKindName: String?
    ) {
        self.amount = amount
        self.numberOfAccounts = numberOfAccounts
        self.productKindName = productKindName
    }
}
