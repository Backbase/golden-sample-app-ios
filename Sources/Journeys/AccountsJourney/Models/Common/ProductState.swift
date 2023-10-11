//
//  ProductState.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 11/10/2023.
//

import Foundation

/**
 * Defines a product state item.
 */
 struct ProductState: Equatable {
    /// An external unique identifier for the arrangement state object.
     let externalStateId: String?
    /// Name that describes the specific arrangement state.
     let state: String?
    /// Any extra information
     let additions: [String: String]?
    
    /// Create a new `ProductState` object.
    /// - Parameters:
    ///   - externalStateId: Optional externalStateId. Defaults to `nil`
    ///   - state: Optional state. Defaults to `nil`
    ///   - additions: Optional additions. Defaults to `nil`
     init(
        externalStateId: String? = nil,
        state: String? = nil,
        additions: [String: String]? = nil
    ) {
        self.externalStateId = externalStateId
        self.state = state
        self.additions = additions
    }
}
