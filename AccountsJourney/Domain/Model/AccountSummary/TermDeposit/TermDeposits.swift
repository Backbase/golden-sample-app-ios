//
//  TermDeposits.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 12/10/2023.
//

import Foundation

extension AccountsJourney {
    public struct TermDeposits: Equatable {
        /// The list of term deposit.
        public let products: [TermDeposit]
        /// The label/name for term deposits.
        public let name: String?
        /// The aggregated balance of this group of products.
        public let aggregatedBalance: AggregatedBalance?
        /// Extra parameters
        public let additions: [String: String]?
        
        /// Creates a `TermsDeposits` object
        /// - Parameters:
        ///   - products: The list of term deposit.
        ///   - name: The label/name for term deposits.
        ///   - aggregatedBalance: The aggregated balance of this group of products.
        ///   - additions: Extra parameters
        public init(
            products: [TermDeposit],
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
