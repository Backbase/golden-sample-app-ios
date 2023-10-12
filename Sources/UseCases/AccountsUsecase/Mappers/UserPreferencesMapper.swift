//
//  UserPreferencesMapper.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 12/10/2023.
//

import Foundation
import ArrangementsClient2Gen2

extension ArrangementsClient2Gen2.UserPreferences {
    func toDomainModel() -> UserPreferences {
        UserPreferences(
            alias: self.alias,
            visible: self.visible,
            favorite: self.favorite,
            additions: self.additions
        )
    }
}
