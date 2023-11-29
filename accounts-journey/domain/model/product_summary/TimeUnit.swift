//
//  TimeUnit.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 11/10/2023.
//

import Foundation

extension AccountsJourney {

    /// The period of time for the product arranged between Bank and customer.
    public enum TimeUnit: String, Codable {
        /// Day, raw value: D
        case day = "D"
        /// Week, raw value: W
        case week = "W"
        /// Month, raw value: M
        case month = "M"
        /// Year, raw value: Y
        case year = "Y"
    }
}
