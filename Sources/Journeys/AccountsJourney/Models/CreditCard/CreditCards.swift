//
//  CreditCards.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 11/10/2023.
//

import Foundation

/// CreditCards
struct CreditCards: Equatable {
    let products: [CreditCard]
    let name: String?
    let aggregatedBalance: AggregatedBalance?
    let additions: [String: String]
    
    /// Create a new `CreditCards` object.
    /// - Parameters:
    ///   - products: List of credit cards
    ///   - name: The label/name of the Credit card
    ///   - aggregatedBalance: The aggregated balance of this group of products.
    ///   - additions: Extra parameters
    init(
        products: [CreditCard],
        name: String?,
        aggregatedBalance: AggregatedBalance?,
        additions: [String : String]
    ) {
        self.products = products
        self.name = name
        self.aggregatedBalance = aggregatedBalance
        self.additions = additions
    }
}
