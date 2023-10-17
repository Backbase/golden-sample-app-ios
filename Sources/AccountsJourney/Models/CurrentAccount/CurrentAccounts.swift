//
//  CurrentAccounts.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 11/10/2023.
//

import Foundation


public struct CurrentAccounts: Equatable {
    /// List of current accounts
    public let product: [CurrentAccount]
    /// The label/name that is used for the respective product kind.
    public let name: String?
    /// The aggregated balance of this group of products.
    public let aggregatedBalance: AggregatedBalance?
    /// Extra parameters
    public let additions: [String: String]?
    
    /// Create a new `CurrentAccounts` object.
    /// - Parameters:
    ///   - product: List of current accounts
    ///   - name: The label/name that is used for the respective product kind.
    ///   - aggregatedBalance: The aggregated balance of this group of products.
    ///   - additions: Extra parameters
    public init(
        product: [CurrentAccount],
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