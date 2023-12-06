//
//  SavingsAccounts.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 11/10/2023.
//

import Foundation

extension AccountsJourney {
    public struct SavingsAccounts: Equatable {
        /// List of savings accounts
        public let products: [SavingsAccount]
        /// the label/name of the saving account
        public let name: String?
        /// The aggregated balance of this group of products.
        public let aggregatedBalance: AggregatedBalance?
        /// Extra parameters
        public let additions: [String: String]?
        
        /// Creates a `SavingsAccounts` item
        /// - Parameters:
        ///   - product: List of savings accounts
        ///   - name: the label/name of the saving account
        ///   - aggregatedBalance: The aggregated balance of this group of products.
        ///   - additions: Extra parameters
        public init(
            products: [SavingsAccount],
            name: String?,
            aggregatedBalance: AggregatedBalance?,
            additions: [String: String]?
        ) {
            self.products = products
            self.name = name
            self.aggregatedBalance = aggregatedBalance
            self.additions = additions
        }
    }
}
