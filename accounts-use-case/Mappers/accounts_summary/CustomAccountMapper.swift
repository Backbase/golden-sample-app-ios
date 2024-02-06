//
//  CustomAccountMapper.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 12/10/2023.
//

import Foundation
import AccountsJourney
import ArrangementsClient2Gen2

extension ArrangementsClient2Gen2.GeneralAccount {
    // swiftlint:disable function_body_length
    public func toDomainModel() -> AccountsJourney.GeneralAccount {
        AccountsJourney.GeneralAccount(
        bookedBalance: self.bookedBalance,
        availableBalance: self.availableBalance,
        creditLimit: self.creditLimit,
        iban: self.IBAN,
        bban: self.BBAN,
        currency: self.currency,
        urgentTransferAllowed: self.urgentTransferAllowed,
        bic: self.BIC,
        bankBranchCode: self.bankBranchCode,
        bankBranchCode2: self.bankBranchCode2,
        accountInterestRate: self.accountInterestRate,
        valueDateBalance: self.valueDateBalance,
        creditLimitUsage: self.creditLimitUsage,
        creditLimitInterestRate: self.creditLimitInterestRate,
        creditLimitExpiryDate: self.creditLimitExpiryDate,
        accruedInterest: self.accruedInterest,
        debitCardsItems: self.debitCardsItems.map { $0.toDomainModel()},
        startDate: self.startDate,
        minimumRequiredBalance: self.minimumRequiredBalance,
        accountHolderAddressLine1: self.accountHolderAddressLine1,
        accountHolderAddressLine2: self.accountHolderAddressLine2,
        accountHolderStreetName: self.accountHolderStreetName,
        town: self.town,
        postCode: self.postCode,
        countrySubDivision: self.countrySubDivision,
        accountHolderNames: self.accountHolderNames,
        accountHolderCountry: self.accountHolderCountry,
        number: self.number,
        cardNumber: self.cardNumber,
        creditCardAccountNumber: self.creditCardAccountNumber,
        validThru: self.validThru,
        applicableInterestRate: self.applicableInterestRate,
        remainingCredit: self.remainingCredit,
        outstandingPayment: self.outstandingPayment,
        minimumPayment: self.minimumPayment,
        minimumPaymentDueDate: self.minimumPaymentDueDate,
        currentInvestmentValue: self.currentInvestmentValue,
        productNumber: self.productNumber,
        principalAmount: self.principalAmount,
        termUnit: self.termUnit?.toDomainModel(),
        termNumber: self.termNumber,
        outstandingPrincipalAmount: self.outstandingPrincipalAmount,
        monthlyInstalmentAmount: self.monthlyInstalmentAmount,
        amountInArrear: self.amountInArrear,
        interestSettlementAccount: self.interestSettlementAccount,
        maturityDate: self.maturityDate,
        maturityAmount: self.maturityAmount,
        autoRenewalIndicator: self.autoRenewalIndicator,
        interestPaymentFrequencyUnit: self.interestPaymentFrequencyUnit?.toDomainModel(),
        interestPaymentFrequencyNumber: self.interestPaymentFrequencyNumber,
        creditAccount: self.creditAccount,
        debitAccount: self.debitAccount,
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
    // swiftlint:enable function_body_length
}

extension ArrangementsClient2Gen2.CustomProductKind {
    public func toDomainModel() -> AccountsJourney.CustomProducts {
        AccountsJourney.CustomProducts(
            products: self.products.map { $0.toDomainModel() },
            name: self.name,
            id: self.id,
            aggregatedBalance: self.aggregatedBalance?.toDomainModel(),
            additions: self.additions
        )
    }
}
