//
//  ExternalProductItem.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 28/11/2023.
//

import Foundation

extension AccountsJourney {
    /// DTO for External product item
    public struct ExternalProductItem: Equatable {
        /// Unique identifier for the product that the arrangement applies to
        public let externalId: String?
        /// The id that is used by the bank to identify the specific product type
        public let externalTypeId: String?
        /// The label/name that is used to label a specific product type.
        public let typeName: String?
        /// External product kind item
        public let productKind: ExternalProductKindItem?
        /// additional fields
        public let additions: [String: String]?
        
        /// Init method for `ExternalProductItem` DTO.
        /// - Parameters:
        ///   - externalId: unique identifier for the product
        ///   - externalTypeId: The ID that is used by the Bank to identify the specific product type
        ///   - typeName: The label/name that is used to label a specific product type.
        ///   - productKind: external product kind item
        ///   - additions: additional fields
        public init(externalId: String? = nil,
                    externalTypeId: String? = nil,
                    typeName: String? = nil,
                    productKind: ExternalProductKindItem? = nil,
                    additions: [String: String]? = nil
        ) {
            self.externalId = externalId
            self.externalTypeId = externalTypeId
            self.typeName = typeName
            self.productKind = productKind
            self.additions = additions
        }
    }
}
