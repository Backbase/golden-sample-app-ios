//
//  TermDeposits.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 12/10/2023.
//

import Foundation


struct TermDeposits: Equatable {
    /// The list of term deposit.
    let products: [TermDeposit]
    /// The label/name for term deposits.
    let name: String?
    /// The aggregated balance of this group of products.
    let aggregatedBalance: AggregatedBalance?
    /// Extra parameters
    let additions: [String: String]?
    
    /// Creates a `TermsDeposits` object
    /// - Parameters:
    ///   - products: The list of term deposit.
    ///   - name: The label/name for term deposits.
    ///   - aggregatedBalance: The aggregated balance of this group of products.
    ///   - additions: Extra parameters
    init(
        products: [TermDeposit],
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
