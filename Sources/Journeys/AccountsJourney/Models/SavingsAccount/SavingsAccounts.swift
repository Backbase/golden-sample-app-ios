//
//  SavingsAccounts.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 11/10/2023.
//

import Foundation

struct SavingsAccounts: Equatable {
    /// List of savings accounts
    let product: [SavingsAccount]
    /// the label/name of the saving account
    let name: String?
    /// The aggregated balance of this group of products.
    let aggregatedBalance: AggregatedBalance?
    /// Extra parameters
    let additions: [String: String]?
    
    /// Creates a `SavingsAccounts` item
    /// - Parameters:
    ///   - product: List of savings accounts
    ///   - name: the label/name of the saving account
    ///   - aggregatedBalance: The aggregated balance of this group of products.
    ///   - additions: Extra parameters
    init(
        product: [SavingsAccount],
        name: String?,
        aggregatedBalance: AggregatedBalance?,
        additions: [String : String]?
    ) {
        self.product = product
        self.name = name
        self.aggregatedBalance = aggregatedBalance
        self.additions = additions
    }
}
