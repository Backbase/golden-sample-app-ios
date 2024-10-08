//
//  ExternalProductItem.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 28/11/2023.
//

import Foundation
import AccountsJourney
import ArrangementsApi

extension ArrangementsApi.ExternalProductItem {
    public func toDomainModel() -> AccountsJourney.ExternalProductItem {
        AccountsJourney.ExternalProductItem(
            externalId: self.externalId,
            externalTypeId: self.externalTypeId,
            typeName: self.typeName,
            productKind: self.productKind?.toDomainModel(),
            additions: self.additions)
    }
}

extension ArrangementsApi.ExternalProductKindItem {
    public func toDomainModel() -> AccountsJourney.ExternalProductKindItem {
        AccountsJourney.ExternalProductKindItem(
            externalKindId: self.externalKindId,
            kindName: self.kindName,
            kindUri: self.kindUri,
            additions: self.additions
        )
    }
}
