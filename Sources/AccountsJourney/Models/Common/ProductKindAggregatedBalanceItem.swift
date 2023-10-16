//
//  ProductKindAggregatedBalanceItem.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 11/10/2023.
//

import Foundation

public struct ProductKindAggregatedBalanceItem: Equatable {
    public let amount: Double?
    public let numberOfAccounts: Int?
    public let productKindName: String?
    
    public init(
        amount: Double?,
        numberOfAccounts: Int?,
        productKindName: String?
    ) {
        self.amount = amount
        self.numberOfAccounts = numberOfAccounts
        self.productKindName = productKindName
    }
}

