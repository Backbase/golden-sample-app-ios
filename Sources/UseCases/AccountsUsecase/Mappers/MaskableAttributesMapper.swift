//
//  MaskableAttributesMapper.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 12/10/2023.
//

import Foundation
import ArrangementsClient2Gen2

extension ArrangementsClient2Gen2.MaskableAttribute {
    func toDomainModel() -> MaskableAttribute {
        MaskableAttribute(rawValue: self.rawValue) ?? .bban
    }
}
