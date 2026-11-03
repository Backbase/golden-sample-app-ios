//
//  ProductKindAggregatedBalanceItem.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 11/10/2023.
//

import Foundation
extension AccountsJourney {
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
}
