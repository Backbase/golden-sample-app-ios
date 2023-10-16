//
//  ProductStateMapper.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 12/10/2023.
//

import Foundation
import AccountsJourney
import ArrangementsClient2Gen2

extension ArrangementsClient2Gen2.StateItem {
    func toDomainModel() -> AccountsJourney.ProductState {
        AccountsJourney.ProductState(
            externalStateId: self.externalStateId,
            state: self.state,
            additions: self.additions
        )
    }
}
