//
//  AccountUserPreferencesMapper.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 28/11/2023.
//

import Foundation
import AccountsJourney
import ArrangementsClient2Gen2

extension ArrangementsClient2Gen2.AccountUserPreferences {
    public func toDomainModel() -> AccountsJourney.AccountUserPreferences {
        AccountsJourney.AccountUserPreferences(
            arrangementId: self.arrangementId,
            alias: self.alias,
            visible: self.visible,
            favorite: self.favorite,
            additions: self.additions)
    }
}
