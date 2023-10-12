//
//  CreditCards.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 11/10/2023.
//

import Foundation

/// CreditCards
struct CreditCards: Equatable {
    /// List of credit cards
    let products: [CreditCard]
    /// The label/name of the Credit cards
    let name: String?
    /// The aggregated balance of this group of products.
    let aggregatedBalance: AggregatedBalance?
    /// Extra parameters
    let additions: [String: String]?
    
    /// Create a new `CreditCards` object.
    /// - Parameters:
    ///   - products: List of credit cards
    ///   - name: The label/name of the Credit cards
    ///   - aggregatedBalance: The aggregated balance of this group of products.
    ///   - additions: Extra parameters
    init(
        products: [CreditCard],
        name: String?,
        aggregatedBalance: AggregatedBalance?,
        additions: [String : String]?
    ) {
        self.products = products
        self.name = name
        self.aggregatedBalance = aggregatedBalance
        self.additions = additions
    }
}
