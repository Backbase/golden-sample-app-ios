//
//  MaskableAttributesMapper.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 12/10/2023.
//

import Foundation
import AccountsJourney
import ArrangementsApi

extension ArrangementsApi.MaskableAttribute {
    public func toDomainModel() -> AccountsJourney.MaskableAttribute {
        AccountsJourney.MaskableAttribute(rawValue: self.rawValue) ?? .bban
    }
}
