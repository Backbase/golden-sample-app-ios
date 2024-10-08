//
// DebitCardItem.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
import ClientCommonGen2


public struct DebitCardItem: Codable, Equatable {
    /** An optional list of the maskable attributes that can be unmasked. */
    public var unmaskableAttributes: [MaskableAttribute]?
    /** First 6 and/or last 4 digits of a Payment card. All other digits will/to be masked. Be aware that using card number differently is potential PCI risk. */
    public var number: String?
    /** Expiration date of a credit card, after which is no longer valid */
    public var expiryDate: String?
    /** External ID of the card */
    public var cardId: String?
    /** First Name and Last Name of card holder. */
    public var cardholderName: String?
    /** Card type to change card image based on it, ex. Maestro Gold */
    public var cardType: String?
    /** Status of the card ex. Active, Expired etc */
    public var cardStatus: String?
    public var additions: [String: String]?

    @available(*, deprecated, message: "This initializer is deprecated, use the initializer and the setters of DebitCardItem.Builder class.")
    public init(unmaskableAttributes: [MaskableAttribute]? = nil, number: String? = nil, expiryDate: String? = nil, cardId: String? = nil, cardholderName: String? = nil, cardType: String? = nil, cardStatus: String? = nil, additions: [String: String]? = nil) {
        self.unmaskableAttributes = unmaskableAttributes
        self.number = number
        self.expiryDate = expiryDate
        self.cardId = cardId
        self.cardholderName = cardholderName
        self.cardType = cardType
        self.cardStatus = cardStatus
        self.additions = additions
    }

    /// Builder class for DebitCardItem DTO.
    public final class Builder: Equatable {
        /** An optional list of the maskable attributes that can be unmasked. */
        public private(set) var unmaskableAttributes: [MaskableAttribute]?
        /** First 6 and/or last 4 digits of a Payment card. All other digits will/to be masked. Be aware that using card number differently is potential PCI risk. */
        public private(set) var number: String?
        /** Expiration date of a credit card, after which is no longer valid */
        public private(set) var expiryDate: String?
        /** External ID of the card */
        public private(set) var cardId: String?
        /** First Name and Last Name of card holder. */
        public private(set) var cardholderName: String?
        /** Card type to change card image based on it, ex. Maestro Gold */
        public private(set) var cardType: String?
        /** Status of the card ex. Active, Expired etc */
        public private(set) var cardStatus: String?
        public private(set) var additions: [String: String]?

        public init() {
        }

        /// Setter method for unmaskableAttributes property.
        public func set(unmaskableAttributes: [MaskableAttribute]?) -> Self {
            self.unmaskableAttributes = unmaskableAttributes
            return self
        }
        /// Setter method for number property.
        public func set(number: String?) -> Self {
            self.number = number
            return self
        }
        /// Setter method for expiryDate property.
        public func set(expiryDate: String?) -> Self {
            self.expiryDate = expiryDate
            return self
        }
        /// Setter method for cardId property.
        public func set(cardId: String?) -> Self {
            self.cardId = cardId
            return self
        }
        /// Setter method for cardholderName property.
        public func set(cardholderName: String?) -> Self {
            self.cardholderName = cardholderName
            return self
        }
        /// Setter method for cardType property.
        public func set(cardType: String?) -> Self {
            self.cardType = cardType
            return self
        }
        /// Setter method for cardStatus property.
        public func set(cardStatus: String?) -> Self {
            self.cardStatus = cardStatus
            return self
        }
        /// Setter method for additions property.
        public func set(additions: [String: String]?) -> Self {
            self.additions = additions
            return self
        }

        /// Builder initializer method for DebitCardItem DTO.
        public func build() -> DebitCardItem {
            return DebitCardItem(unmaskableAttributes: unmaskableAttributes, 
                    number: number, 
                    expiryDate: expiryDate, 
                    cardId: cardId, 
                    cardholderName: cardholderName, 
                    cardType: cardType, 
                    cardStatus: cardStatus, 
                    additions: additions)
        }

        public static func ==(lhs: Builder, rhs: Builder) -> Bool {
            return lhs.unmaskableAttributes == rhs.unmaskableAttributes &&
            lhs.number == rhs.number &&
            lhs.expiryDate == rhs.expiryDate &&
            lhs.cardId == rhs.cardId &&
            lhs.cardholderName == rhs.cardholderName &&
            lhs.cardType == rhs.cardType &&
            lhs.cardStatus == rhs.cardStatus &&
            lhs.additions == rhs.additions
        }
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: String.self)
        try container.encodeIfPresent(unmaskableAttributes, forKey: "unmaskableAttributes")
        try container.encodeIfPresent(number, forKey: "number")
        try container.encodeIfPresent(expiryDate, forKey: "expiryDate")
        try container.encodeIfPresent(cardId, forKey: "cardId")
        try container.encodeIfPresent(cardholderName, forKey: "cardholderName")
        try container.encodeIfPresent(cardType, forKey: "cardType")
        try container.encodeIfPresent(cardStatus, forKey: "cardStatus")
        try container.encodeIfPresent(additions, forKey: "additions")
    }

    // Decodable protocol methods

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)
        unmaskableAttributes = try container.decodeIfPresent([MaskableAttribute].self, forKey: "unmaskableAttributes")
        number = try container.decodeIfPresent(String.self, forKey: "number")
        expiryDate = try container.decodeIfPresent(String.self, forKey: "expiryDate")
        cardId = try container.decodeIfPresent(String.self, forKey: "cardId")
        cardholderName = try container.decodeIfPresent(String.self, forKey: "cardholderName")
        cardType = try container.decodeIfPresent(String.self, forKey: "cardType")
        cardStatus = try container.decodeIfPresent(String.self, forKey: "cardStatus")
        additions = try container.decodeIfPresent([String: String].self, forKey: "additions")
    }

    public static func ==(lhs: DebitCardItem, rhs: DebitCardItem) -> Bool {
        return lhs.unmaskableAttributes == rhs.unmaskableAttributes &&
        lhs.number == rhs.number &&
        lhs.expiryDate == rhs.expiryDate &&
        lhs.cardId == rhs.cardId &&
        lhs.cardholderName == rhs.cardholderName &&
        lhs.cardType == rhs.cardType &&
        lhs.cardStatus == rhs.cardStatus &&
        lhs.additions == rhs.additions
    }


}
