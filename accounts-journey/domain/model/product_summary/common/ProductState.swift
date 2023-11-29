//
//  ProductState.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 11/10/2023.
//

import Foundation
extension AccountsJourney {
    /// Defines a product state item.
    public struct ProductState: Codable, Equatable {
        /// An external unique identifier for the arrangement state object.
        public let externalStateId: String?
        /// Name that describes the specific arrangement state.
        public let state: String?
        /// Any extra information
        public let additions: [String: String]?
        
        /// Create a new `ProductState` object.
        /// - Parameters:
        ///   - externalStateId: Optional externalStateId. Defaults to `nil`
        ///   - state: Optional state. Defaults to `nil`
        ///   - additions: Optional additions. Defaults to `nil`
        public init(
            externalStateId: String? = nil,
            state: String? = nil,
            additions: [String: String]? = nil
        ) {
            self.externalStateId = externalStateId
            self.state = state
            self.additions = additions
        }
    }
}
