//
//  CustomProducts.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 11/10/2023.
//

import Foundation

extension AccountsJourney {
    public struct CustomProducts: Codable, Equatable {
        /// A list of custom products.
        public let products: [GeneralAccount]
        /// label/name that is used for this particular group of custom products.
        public let name: String?
        /// The id of this group of custom products.
        public let id: Int?
        /// The aggregated balance of this group of products.
        public let aggregatedBalance: AggregatedBalance?
        /// Extra information.
        public let additions: [String: String]?
        
        /// Create a new `CustomProducts` object.
        /// - Parameters:
        ///   - products: A list of custom products.
        ///   - name: label/name that is used for this particular group of custom products.
        ///   - id: The id of this group of custom products.
        ///   - aggregatedBalance: The aggregated balance of this group of products.
        ///   - additions: Extra information.
        public init(
            products: [GeneralAccount],
            name: String?,
            id: Int?,
            aggregatedBalance: AggregatedBalance?,
            additions: [String: String]?
        ) {
            self.products = products
            self.name = name
            self.id = id
            self.aggregatedBalance = aggregatedBalance
            self.additions = additions
        }
    }
}
