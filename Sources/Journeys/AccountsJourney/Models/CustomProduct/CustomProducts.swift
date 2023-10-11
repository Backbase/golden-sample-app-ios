//
//  CustomProducts.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 11/10/2023.
//

import Foundation

struct CustomProducts: Equatable {
    let products: [GeneralAccount]
    let name: String?
    let id: Int
    let aggregatedBalance: AggregatedBalance?
    let additions: [String: String]?
    
    /// Create a new `CustomProducts` object.
    /// - Parameters:
    ///   - products: A list of custom products.
    ///   - name: label/name that is used for this particular group of custom products.
    ///   - id: The id of this group of custom products.
    ///   - aggregatedBalance: The aggregated balance of this group of products.
    ///   - additions: Extra information.
    init(
        products: [GeneralAccount],
        name: String?,
        id: Int,
        aggregatedBalance: AggregatedBalance?,
        additions: [String : String]?
    ) {
        self.products = products
        self.name = name
        self.id = id
        self.aggregatedBalance = aggregatedBalance
        self.additions = additions
    }
    
}
