//
//  MaskableAttribute.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 11/10/2023.
//

import Foundation

extension AccountsJourney {
    /// A DTO for `MaskableAttribute`.
    public enum MaskableAttribute: String, Codable, CaseIterable {
        /// The maskable attribute that can be unmasked for Current and Savings accounts.
        case iban = "IBAN"
        /// The maskable attribute that can be unmasked for Current and Savings accounts.
        case bban = "BBAN"
        /// The maskable attribute that can be unmasked for Credit Card accounts.
        case number = "number"
    }
}
