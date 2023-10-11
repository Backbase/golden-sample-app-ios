//
//  DebitCards.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 11/10/2023.
//

import Foundation

/// DebitCards
struct DebitCards: Equatable {
    let products: [DebitCard]
    let name: String?
    let displayName: String?
    let aggregatedBalance: AggregatedBalance?
    let additions: [String: String]
    
    /// Create a `DebitCards` item
    /// - Parameters:
    ///   - products: The list of debit cards.
    ///   - name: The label/name of the debit card.
    ///   - displayName: The label/name of the debit card used to display on the screen.
    ///   - aggregatedBalance: The aggregated balance of this group of products.
    ///   - additions: Extra parameters
    init(
        products: [DebitCard],
        name: String?,
        displayName: String?,
        aggregatedBalance: AggregatedBalance?,
        additions: [String : String]
    ) {
        self.products = products
        self.name = name
        self.displayName = displayName
        self.aggregatedBalance = aggregatedBalance
        self.additions = additions
    }
}
