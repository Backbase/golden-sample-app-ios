//
//  TermDepositMapper.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 12/10/2023.
//

import Foundation
import AccountsJourney
import ArrangementsClient2Gen2

extension ArrangementsClient2Gen2.TermDeposit {
   public func toDomainModel() -> AccountsJourney.TermDeposit {
        AccountsJourney.TermDeposit(
            bookedBalance: self.bookedBalance,
            principalAmount: self.principalAmount,
            accruedInterest: self.accruedInterest,
            iban: self.IBAN,
            bban: self.BBAN,
            currency: self.currency,
            urgentTransferAllowed: self.urgentTransferAllowed,
            productNumber: self.productNumber,
            accountInterestRate: self.accountInterestRate,
            startDate: self.startDate,
            termUnit: self.termUnit?.toDomainModel(),
            termNumber: self.termNumber,
            maturityDate: self.maturityDate,
            maturityAmount: self.maturityAmount,
            autoRenewalIndicator: self.autoRenewalIndicator,
            interestPaymentFrequencyUnit: self.interestPaymentFrequencyUnit?.toDomainModel(),
            interestPaymentFrequencyNumber: self.interestPaymentFrequencyNumber,
            interestSettlementAccount: self.interestSettlementAccount,
            valueDateBalance: self.valueDateBalance,
            accountHolderNames: self.accountHolderNames,
            outstandingPrincipalAmount: self.outstandingPrincipalAmount,
            creditAccount: self.creditAccount,
            debitAccount: self.debitAccount,
            minimumRequiredBalance: self.minimumRequiredBalance,
            additions: self.additions,
            identifier: self.id,
            unmaskableAttributes: self.unmaskableAttributes?.map { $0.toDomainModel() },
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
            bankBranchCode: self.bankBranchCode2
        )
    }
}

extension ArrangementsClient2Gen2.TermDepositProductKinds {
    func toDomainModel() -> AccountsJourney.TermDeposits {
        AccountsJourney.TermDeposits(
            products: self.products.map { $0.toDomainModel() },
            name: self.name,
            aggregatedBalance: self.aggregatedBalance?.toDomainModel(),
            additions: self.additions
        )
    }
}
