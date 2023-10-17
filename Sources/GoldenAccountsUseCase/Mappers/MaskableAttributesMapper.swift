//
//  MaskableAttributesMapper.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 12/10/2023.
//

import Foundation
import AccountsJourney
import ArrangementsClient2Gen2

extension ArrangementsClient2Gen2.MaskableAttribute {
    public func toDomainModel() -> AccountsJourney.MaskableAttribute {
        AccountsJourney.MaskableAttribute(rawValue: self.rawValue) ?? .bban
    }
}
