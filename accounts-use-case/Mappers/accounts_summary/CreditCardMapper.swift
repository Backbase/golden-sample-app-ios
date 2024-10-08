//
//  CreditCardMapper.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 12/10/2023.
//

import Foundation
import AccountsJourney
import ArrangementsApi

extension ArrangementsApi.CreditCard {
    public func toDomainModel() -> AccountsJourney.CreditCard {
        AccountsJourney.CreditCard(
            bookedBalance: self.bookedBalance,
            availableBalance: self.availableBalance,
            creditLimit: self.creditLimit,
            number: self.number,
            currency: self.currency,
            urgentTransferAllowed: self.urgentTransferAllowed,
            cardNumber: self.cardNumber,
            creditCardAccountNumber: self.creditCardAccountNumber,
            bankBranchCode2: self.bankBranchCode2,
            validThru: self.validThru,
            applicableInterestRate: self.applicableInterestRate,
            remainingCredit: self.remainingCredit,
            outstandingPayment: self.outstandingPayment,
            minimumPayment: self.minimumPayment,
            minimumPaymentDueDate: self.minimumPaymentDueDate,
            accountInterestRate: self.accountInterestRate,
            accountHolderNames: self.accountHolderNames,
            creditLimitUsage: self.creditLimitUsage,
            creditLimitInterestRate: self.creditLimitInterestRate,
            accruedInterest: self.accruedInterest,
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
            cardDetails: self.cardDetails?.toDomainModel(),
            interestDetails: self.interestDetails?.toDomainModel(),
            reservedAmount: self.reservedAmount,
            remainingPeriodicTransfers: self.remainingPeriodicTransfers,
            nextClosingDate: self.nextClosingDate,
            overdueSince: self.overdueSince,
            externalAccountStatus: self.externalAccountStatus
        )
    }
}

extension ArrangementsApi.CreditCardProductKinds {
    public func toDomainModel() -> AccountsJourney.CreditCards {
        AccountsJourney.CreditCards(
            products: self.products.map { $0.toDomainModel() },
            name: self.name,
            aggregatedBalance: self.aggregatedBalance?.toDomainModel(),
            additions: self.additions
        )
    }
}
