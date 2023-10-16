//
//  DebitCardItem.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 11/10/2023.
//

import Foundation

/// Debit Card item response DTO.
public struct DebitCardItem: Equatable {
    
    /// First 6 and/or last 4 digits of a Payment card. All other digits will/to be masked.
    /// Be aware that using card number differently is potential PCI risk
    public let number: String?
    
    /// Expiration date of a credit card, after which is no longer valid
    public let expiryDate: String?
    
    /// External ID of the card
    public let cardId: String?
    
    /// First Name and Last Name of card holder.
    public let cardholderName: String?
    
    /// Card type to change card image based on it, ex. Maestro Gold.
    public let cardType: String?
    
    /// Status of the card ex. Active, Expired etc.
    public let cardStatus: String?
    
    /// Additional fields
    public let additions: [String: String]?
    
    /// Create a new `DebitCardItem` object.
    /// - Parameters:
    ///   - number: Optional number. Defaults to `nil`
    ///   - expiryDate: Expiration date of a debit card, after which is no longer valid.
    ///   - cardId: External ID of the card.
    ///   - cardholderName: First Name and Last Name of card holder.
    ///   - cardType: Card type to change card image based on it, ex. Maestro Gold
    ///   - cardStatus: Status of the card ex. Active, Expired etc.
    ///   - additions: Extra parameters
    public init(
        number: String? = nil,
        expiryDate: String? = nil,
        cardId: String? = nil,
        cardholderName: String? = nil,
        cardType: String? = nil,
        cardStatus: String? = nil,
        additions: [String: String]? = nil
    ) {
        self.number = number
        self.expiryDate = expiryDate
        self.cardId = cardId
        self.cardholderName = cardholderName
        self.cardType = cardType
        self.cardStatus = cardStatus
        self.additions = additions
    }
}
