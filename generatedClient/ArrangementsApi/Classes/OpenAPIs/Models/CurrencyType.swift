//
// CurrencyType.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
import ClientCommonGen2


public struct CurrencyType: Codable, Equatable {
    /** The amount in the specified currency */
    public var amount: String
    /** The alpha-3 code (complying with ISO 4217) of the currency that qualifies the amount. */
    public var currencyCode: String
    public var additions: [String: String]?

    @available(*, deprecated, message: "This initializer is deprecated, use the initializer and the setters of CurrencyType.Builder class.")
    public init(amount: String, currencyCode: String, additions: [String: String]? = nil) {
        self.amount = amount
        self.currencyCode = currencyCode
        self.additions = additions
    }

    /// Builder class for CurrencyType DTO.
    public final class Builder: Equatable {
        /** The amount in the specified currency */
        public let amount: String
        /** The alpha-3 code (complying with ISO 4217) of the currency that qualifies the amount. */
        public let currencyCode: String
        public private(set) var additions: [String: String]?

        public init(amount: String, currencyCode: String) {
            self.amount = amount
            self.currencyCode = currencyCode
        }

        /// Setter method for additions property.
        public func set(additions: [String: String]?) -> Self {
            self.additions = additions
            return self
        }

        /// Builder initializer method for CurrencyType DTO.
        public func build() -> CurrencyType {
            return CurrencyType(amount: amount, 
                    currencyCode: currencyCode, 
                    additions: additions)
        }

        public static func ==(lhs: Builder, rhs: Builder) -> Bool {
            return lhs.amount == rhs.amount &&
            lhs.currencyCode == rhs.currencyCode &&
            lhs.additions == rhs.additions
        }
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: String.self)
        try container.encode(amount, forKey: "amount")
        try container.encode(currencyCode, forKey: "currencyCode")
        try container.encodeIfPresent(additions, forKey: "additions")
    }

    // Decodable protocol methods

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)
        amount = try container.decode(String.self, forKey: "amount")
        currencyCode = try container.decode(String.self, forKey: "currencyCode")
        additions = try container.decodeIfPresent([String: String].self, forKey: "additions")
    }

    public static func ==(lhs: CurrencyType, rhs: CurrencyType) -> Bool {
        return lhs.amount == rhs.amount &&
        lhs.currencyCode == rhs.currencyCode &&
        lhs.additions == rhs.additions
    }


}
