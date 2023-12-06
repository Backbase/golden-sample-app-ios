//
//  InvestmentAccounts.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 11/10/2023.
//

import Foundation

extension AccountsJourney {
    public struct InvestmentAccounts: Equatable {
        /// The list of investments.
        public let products: [InvestmentAccount]
        /// The label/name of an investment account.
        public let name: String?
        /// The aggregated balance of this group of products.
        public let aggregatedBalance: AggregatedBalance?
        /// Extra parameters
        public let additions: [String: String]?
        
        /// Creates a `InvestmentAccounts` item
        /// - Parameters:
        ///   - products: The list of investments.
        ///   - name: The label/name of an investment account.
        ///   - aggregatedBalance: The aggregated balance of this group of products.
        ///   - additions: Extra parameters
        public init(
            products: [InvestmentAccount],
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
