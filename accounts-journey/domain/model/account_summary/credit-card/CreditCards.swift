//
//  CreditCards.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 11/10/2023.
//

import Foundation
extension AccountsJourney {
    /// CreditCards
    public struct CreditCards: Equatable {
        /// List of credit cards
        public let products: [CreditCard]
        /// The label/name of the Credit cards
        public let name: String?
        /// The aggregated balance of this group of products.
        public let aggregatedBalance: AggregatedBalance?
        /// Extra parameters
        public let additions: [String: String]?
        
        /// Create a new `CreditCards` object.
        /// - Parameters:
        ///   - products: List of credit cards
        ///   - name: The label/name of the Credit cards
        ///   - aggregatedBalance: The aggregated balance of this group of products.
        ///   - additions: Extra parameters
        public init(
            products: [CreditCard],
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
