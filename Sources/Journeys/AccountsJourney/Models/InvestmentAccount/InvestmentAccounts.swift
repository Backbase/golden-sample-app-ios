//
//  InvestmentAccounts.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 11/10/2023.
//

import Foundation

struct InvestmentAccounts: Equatable {
    /// The list of investments.
    let products: [InvestmentAccount]
    /// The label/name of an investment account.
    let name: String?
    /// The aggregated balance of this group of products.
    let aggregatedBalance: AggregatedBalance?
    /// Extra parameters
    let additions: [String: String]
    
    /// Creates a `InvestmentAccounts` item
    /// - Parameters:
    ///   - products: The list of investments.
    ///   - name: The label/name of an investment account.
    ///   - aggregatedBalance: The aggregated balance of this group of products.
    ///   - additions: Extra parameters
    init(
        products: [InvestmentAccount],
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
