//
//  ProductStateMapper.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 12/10/2023.
//

import Foundation
import ArrangementsClient2Gen2

extension ArrangementsClient2Gen2.StateItem {
    func toDomainModel() -> ProductState {
        ProductState(
            externalStateId: self.externalStateId,
            state: self.state,
            additions: self.additions
        )
    }
}
