//
//  ProductKindAggregatedBalanceItem.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 11/10/2023.
//

import Foundation

struct ProductKindAggregatedBalanceItem: Equatable {
    let amount: Float?
    let numberOfAccounts: Int?
    let productKindName: String?
    
    init(
        amount: Float?,
        numberOfAccounts: Int?,
        productKindName: String?
    ) {
        self.amount = amount
        self.numberOfAccounts = numberOfAccounts
        self.productKindName = productKindName
    }
}
