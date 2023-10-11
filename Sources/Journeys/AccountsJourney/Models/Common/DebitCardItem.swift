//
//  DebitCardItem.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 11/10/2023.
//

import Foundation

/// Debit Card item response DTO.
 struct DebitCardItem: Equatable {
    
    /// First 6 and/or last 4 digits of a Payment card. All other digits will/to be masked.
    /// Be aware that using card number differently is potential PCI risk
     let number: String?
    
    /// Expiration date of a credit card, after which is no longer valid
     let expiryDate: String?
    
    /// External ID of the card
     let cardId: String?
    
    /// First Name and Last Name of card holder.
     let cardholderName: String?
    
    /// Card type to change card image based on it, ex. Maestro Gold.
     let cardType: String?
    
    /// Status of the card ex. Active, Expired etc.
     let cardStatus: String?
    
    /// Additional fields
     let additions: [String: String]?
    
    /// Create a new `DebitCardItem` object.
    /// - Parameters:
    ///   - number: Optional number. Defaults to `nil`
    ///   - expiryDate: Expiration date of a debit card, after which is no longer valid.
    ///   - cardId: External ID of the card.
    ///   - cardholderName: First Name and Last Name of card holder.
    ///   - cardType: Card type to change card image based on it, ex. Maestro Gold
    ///   - cardStatus: Status of the card ex. Active, Expired etc.
    ///   - additions: Extra parameters
     init(
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
