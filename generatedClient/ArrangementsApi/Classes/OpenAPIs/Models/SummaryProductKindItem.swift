//
// SummaryProductKindItem.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
import ClientCommonGen2


public struct SummaryProductKindItem: Codable, Equatable {
    /** DB internal id for product kinds. Since kinds will be static, DB id is deprecated. */
    public var id: Int
    public var externalKindId: String
    public var kindName: String
    public var kindUri: String
    public var additions: [String: String]?

    @available(*, deprecated, message: "This initializer is deprecated, use the initializer and the setters of SummaryProductKindItem.Builder class.")
    public init(id: Int, externalKindId: String, kindName: String, kindUri: String, additions: [String: String]? = nil) {
        self.id = id
        self.externalKindId = externalKindId
        self.kindName = kindName
        self.kindUri = kindUri
        self.additions = additions
    }

    /// Builder class for SummaryProductKindItem DTO.
    public final class Builder: Equatable {
        /** DB internal id for product kinds. Since kinds will be static, DB id is deprecated. */
        public let id: Int
        public let externalKindId: String
        public let kindName: String
        public let kindUri: String
        public private(set) var additions: [String: String]?

        public init(id: Int, externalKindId: String, kindName: String, kindUri: String) {
            self.id = id
            self.externalKindId = externalKindId
            self.kindName = kindName
            self.kindUri = kindUri
        }

        /// Setter method for additions property.
        public func set(additions: [String: String]?) -> Self {
            self.additions = additions
            return self
        }

        /// Builder initializer method for SummaryProductKindItem DTO.
        public func build() -> SummaryProductKindItem {
            return SummaryProductKindItem(id: id, 
                    externalKindId: externalKindId, 
                    kindName: kindName, 
                    kindUri: kindUri, 
                    additions: additions)
        }

        public static func ==(lhs: Builder, rhs: Builder) -> Bool {
            return lhs.id == rhs.id &&
            lhs.externalKindId == rhs.externalKindId &&
            lhs.kindName == rhs.kindName &&
            lhs.kindUri == rhs.kindUri &&
            lhs.additions == rhs.additions
        }
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: String.self)
        try container.encode(id, forKey: "id")
        try container.encode(externalKindId, forKey: "externalKindId")
        try container.encode(kindName, forKey: "kindName")
        try container.encode(kindUri, forKey: "kindUri")
        try container.encodeIfPresent(additions, forKey: "additions")
    }

    // Decodable protocol methods

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)
        id = try container.decode(Int.self, forKey: "id")
        externalKindId = try container.decode(String.self, forKey: "externalKindId")
        kindName = try container.decode(String.self, forKey: "kindName")
        kindUri = try container.decode(String.self, forKey: "kindUri")
        additions = try container.decodeIfPresent([String: String].self, forKey: "additions")
    }

    public static func ==(lhs: SummaryProductKindItem, rhs: SummaryProductKindItem) -> Bool {
        return lhs.id == rhs.id &&
        lhs.externalKindId == rhs.externalKindId &&
        lhs.kindName == rhs.kindName &&
        lhs.kindUri == rhs.kindUri &&
        lhs.additions == rhs.additions
    }


}
