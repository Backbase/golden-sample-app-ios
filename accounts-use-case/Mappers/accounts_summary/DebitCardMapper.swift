//
//  DebitCardMapper.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 12/10/2023.
//

import Foundation
import AccountsJourney
import ArrangementsClient2Gen2

extension ArrangementsClient2Gen2.DebitCard {
    public func toDomainModel() -> AccountsJourney.DebitCard {
        AccountsJourney.DebitCard(
            number: self.number,
            urgentTransferAllowed: self.urgentTransferAllowed,
            cardNumber: self.cardNumber,
            accountInterestRate: self.accountInterestRate,
            accountHolderNames: self.accountHolderNames,
            debitCardsItems: self.debitCardsItems.map { $0.toDomainModel()},
            startDate: self.startDate,
            validThru: self.validThru,
            additions: self.additions,
            identifier: self.id,
            unmaskableAttributes: self.unmaskableAttributes?.map {$0.toDomainModel()},
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
            bankBranchCode2: self.bankBranchCode2,
            nextClosingDate: self.nextClosingDate,
            reservedAmount: self.reservedAmount,
            remainingPeriodicTransfers: self.remainingPeriodicTransfers,
            overdueSince: self.overdueSince,
            externalAccountStatus: self.externalAccountStatus,
            cardDetails: self.cardDetails?.toDomainModel(),
            interestDetails: self.interestDetails?.toDomainModel()
        )
    }
}


extension ArrangementsClient2Gen2.DebitCardItem {
    public func toDomainModel() -> AccountsJourney.DebitCardItem {
        AccountsJourney.DebitCardItem(
            number: self.number,
            expiryDate: self.expiryDate,
            cardId: self.cardId,
            cardholderName: self.cardholderName,
            cardType: self.cardType,
            cardStatus: self.cardStatus,
            additions: self.additions
        )
    }
}


extension ArrangementsClient2Gen2.DebitCardProductKinds {
    public func toDomainModel() -> AccountsJourney.DebitCards {
        AccountsJourney.DebitCards(
            products: self.products.map { $0.toDomainModel() },
            name: self.name,
            displayName: self.name,
            aggregatedBalance: self.aggregatedBalance?.toDomainModel(),
            additions: self.additions
        )
    }
}
