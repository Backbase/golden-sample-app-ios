//
//  Loans.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 11/10/2023.
//

import Foundation

struct Loans: Equatable {
    /// The list of loans.
    let products: [Loan]
    /// The name of the loan grouping
    let name: String?
    /// The label/name of a Loan used to display on screen.
    let displayName: String?
    /// The aggregated balance of this group of products.
    let aggregatedBalance: AggregatedBalance?
    /// Extra parameters
    let additions: [String: String]
    
    /// Create a `Loans` item
    /// - Parameters:
    ///   - products: The list of loans.
    ///   - name: The name of the loan grouping
    ///   - displayName: The label/name of a Loan used to display on screen.
    ///   - aggregatedBalance: The aggregated balance of this group of products.
    ///   - additions: Extra parameters
    init(
        products: [Loan],
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
