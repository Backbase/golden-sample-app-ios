//
//  InvestmentAccountMapper.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 12/10/2023.
//

import Foundation
import ArrangementsClient2Gen2

extension ArrangementsClient2Gen2.InvestmentAccount {
    func toDomainModel() -> InvestmentAccount {
        InvestmentAccount(
            currentInvestmentValue: self.currentInvestmentValue,
            currency: self.currency,
            urgentTransferAllowed: self.urgentTransferAllowed,
            productNumber: self.productNumber,
            iban: self.IBAN,
            bban: self.BBAN,
            additions: self.additions,
            identifier: self.id,
            unmaskableAttributes: self.unmaskableAttributes?.map { $0.toDomainModel()},
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
            interestDetails: self.interestDetails?.toDomainModel(),
            accountHolderNames: nil
        )
    }
}

extension ArrangementsClient2Gen2.InvestmentAccountProductKinds {
    func toDomainModel() -> InvestmentAccounts {
        InvestmentAccounts(
            products: self.products.map { $0.toDomainModel() },
            name: self.name,
            aggregatedBalance: self.aggregatedBalance?.toDomainModel(),
            additions: self.additions
        )
    }
}
