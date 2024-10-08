//
//  UserPreferencesMapper.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 12/10/2023.
//

import Foundation
import AccountsJourney
import ArrangementsApi

extension ArrangementsApi.UserPreferences {
   public func toDomainModel() -> AccountsJourney.UserPreferences {
        AccountsJourney.UserPreferences(
            alias: self.alias,
            visible: self.visible,
            favorite: self.favorite,
            additions: self.additions
        )
    }
}
