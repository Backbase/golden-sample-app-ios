//
//  BaseProductMapper.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 12/10/2023.
//

import Foundation
import AccountsJourney
import ArrangementsClient2Gen2

extension ArrangementsClient2Gen2.BaseProduct {
    func toDomainModel() -> AccountsJourney.BaseProduct {
        AccountsJourney.BaseProduct(
            identifier: self.id,
            name: self.name,
            displayName: self.displayName,
            externalTransferAllowed: self.externalTransferAllowed,
            crossCurrencyAllowed: self.crossCurrencyAllowed,
            productKindName: self.productKindName,
            productTypeName: self.productTypeName,
            bankAlias: self.bankAlias,
            sourceId: self.sourceId,
            visible: self.visible,
            accountOpeningDate: self.accountOpeningDate,
            lastUpdateDate: self.lastUpdateDate,
            userPreferences: self.userPreferences?.toDomainModel(),
            state: self.state?.toDomainModel(),
            parentId: self.parentId,
            subArrangements: self.subArrangements?.map { $0.toDomainModel() },
            financialInstitutionId: self.financialInstitutionId,
            lastSyncDate: self.lastSyncDate,
            additions: self.additions,
            cardDetails: self.cardDetails?.toDomainModel(),
            bankBranchCode2: self.bankBranchCode2,
            nextClosingDate: self.nextClosingDate,
            interestDetails: self.interestDetails?.toDomainModel(),
            externalAccountStatus: self.externalAccountStatus,
            remainingPeriodicTransfers: self.remainingPeriodicTransfers,
            reservedAmount: self.reservedAmount,
            overdueSince: self.overdueSince
        )
    }
}
