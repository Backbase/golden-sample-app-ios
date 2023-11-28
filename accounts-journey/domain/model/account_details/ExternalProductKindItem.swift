//
//  ExternalProductKindItem.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 28/11/2023.
//

import Foundation

extension AccountsJourney {
    /// DTO for External product kind item
    public struct ExternalProductKindItem: Equatable {
        /// unique external identifier for the product kind
        public let externalKindId: String
        /// unique product kind item
        public let kindName: String
        /// unique product kind uri
        public let kindUri: String
        /// additional fields
        public let additions: [String: String]?
        
        /// Init for `ExternalProductKindItem`
        /// - Parameters:
        ///   - externalKindId: unique external identifier for the product kind
        ///   - kindName: unique product kind name
        ///   - kindUri: unique product kind uri
        ///   - additions: additional fields
        public init(externalKindId: String,
                    kindName: String,
                    kindUri: String,
                    additions: [String: String]?
        ) {
            self.externalKindId = externalKindId
            self.kindName = kindName
            self.kindUri = kindUri
            self.additions = additions
        }
    }
}
