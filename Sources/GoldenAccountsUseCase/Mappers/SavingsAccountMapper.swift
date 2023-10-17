//
//  SavingsAccountMapper.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 12/10/2023.
//

import Foundation
import AccountsJourney
import ArrangementsClient2Gen2


extension ArrangementsClient2Gen2.SavingsAccount {
   public func toDomainModel() -> AccountsJourney.SavingsAccount {
        AccountsJourney.SavingsAccount(
            bookedBalance: self.bookedBalance,
            availableBalance: self.availableBalance,
            accruedInterest: self.accruedInterest,
            iban: self.IBAN,
            bban: self.BBAN,
            currency: self.currency,
            urgentTransferAllowed: self.urgentTransferAllowed,
            bic: self.BIC,
            bankBranchCode: self.bankBranchCode,
            bankBranchCode2: self.bankBranchCode2,
            accountInterestRate: self.accountInterestRate,
            minimumRequiredBalance: self.minimumRequiredBalance,
            startDate: self.startDate,
            termUnit: self.termUnit?.toDomainModel(),
            termNumber: self.termNumber,
            maturityDate: self.maturityDate,
            maturityAmount: self.maturityAmount,
            autoRenewalIndicator: self.autoRenewalIndicator,
            interestPaymentFrequencyUnit: self.interestPaymentFrequencyUnit?.toDomainModel(),
            interestPaymentFrequencyNumber: self.interestPaymentFrequencyNumber,
            principalAmount: self.principalAmount,
            interestSettlementAccount: self.interestSettlementAccount,
            accountHolderNames: self.accountHolderNames,
            valueDateBalance: self.valueDateBalance,
            accountHolderAddressLine1: self.accountHolderAddressLine1,
            accountHolderAddressLine2: self.accountHolderAddressLine2,
            accountHolderStreetName: self.accountHolderStreetName,
            town: self.town,
            postCode: self.postCode,
            countrySubDivision: self.countrySubDivision,
            accountHolderCountry: self.accountHolderCountry,
            creditAccount: self.creditAccount,
            debitAccount: self.debitAccount,
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
            subArrangements: self.subArrangements?.map { $0.toDomainModel()},
            financialInstitutionId: self.financialInstitutionId,
            lastSyncDate: self.lastSyncDate,
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


extension ArrangementsClient2Gen2.SavingsAccountProductKinds {
    public func toDomainModel() -> AccountsJourney.SavingsAccounts {
        AccountsJourney.SavingsAccounts(
            product: self.products.map { $0.toDomainModel() },
            name: self.name,
            aggregatedBalance: self.aggregatedBalance?.toDomainModel(),
            additions: self.additions
        )
    }
}

