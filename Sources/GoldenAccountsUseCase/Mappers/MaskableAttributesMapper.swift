//
//  MaskableAttributesMapper.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 12/10/2023.
//

import Foundation
import AccountsJourney
import ArrangementsClient2Gen2

extension ArrangementsClient2Gen2.MaskableAttribute {
    func toDomainModel() -> AccountsJourney.MaskableAttribute {
        AccountsJourney.MaskableAttribute(rawValue: self.rawValue) ?? .bban
    }
}
