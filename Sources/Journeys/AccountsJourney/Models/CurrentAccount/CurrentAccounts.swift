//
//  CurrentAccounts.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 11/10/2023.
//

import Foundation

struct CurrentAccounts: Equatable {
    /// List of current accounts
    let product: [CurrentAccount]
    /// The label/name that is used for the respective product kind.
    let name: String?
    /// The aggregated balance of this group of products.
    let aggregatedBalance: AggregatedBalance?
    /// Extra parameters
    let additions: [String: String]
    
    /// Create a new `CurrentAccounts` object.
    /// - Parameters:
    ///   - product: List of current accounts
    ///   - name: The label/name that is used for the respective product kind.
    ///   - aggregatedBalance: The aggregated balance of this group of products.
    ///   - additions: Extra parameters
    init(
        product: [CurrentAccount],
        name: String?,
        aggregatedBalance: AggregatedBalance?,
        additions: [String : String]
    ) {
        self.product = product
        self.name = name
        self.aggregatedBalance = aggregatedBalance
        self.additions = additions
    }
}
