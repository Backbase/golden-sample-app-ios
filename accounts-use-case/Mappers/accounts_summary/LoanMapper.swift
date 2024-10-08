//
//  LoanMapper.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 12/10/2023.
//

import Foundation
import AccountsJourney
import ArrangementsApi

extension ArrangementsApi.Loan {
    // swiftlint:disable function_body_length
    public func toDomainModel() -> AccountsJourney.Loan {
        AccountsJourney.Loan(
            bookedBalance: self.bookedBalance,
            principalAmount: self.principalAmount,
            currency: self.currency,
            urgentTransferAllowed: self.urgentTransferAllowed,
            productNumber: self.productNumber,
            accountInterestRate: self.accountInterestRate,
            termUnit: self.termUnit?.toDomainModel(),
            termNumber: self.termNumber,
            outstandingPrincipalAmount: self.outstandingPrincipalAmount,
            monthlyInstalmentAmount: self.monthlyInstalmentAmount,
            amountInArrear: self.amountInArrear,
            interestSettlementAccount: self.interestSettlementAccount,
            accruedInterest: self.accruedInterest,
            accountHolderNames: self.accountHolderNames,
            maturityDate: self.maturityDate,
            valueDateBalance: self.valueDateBalance,
            creditAccount: self.creditAccount,
            debitAccount: self.debitAccount,
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
            bankBranchCode: self.bankBranchCode2
        )
    }
    // swiftlint:enable function_body_length
}

extension ArrangementsApi.LoanProductKinds {
    public func toDomainModel() -> AccountsJourney.Loans {
        AccountsJourney.Loans(
            products: self.products.map { $0.toDomainModel() },
            name: self.name,
            displayName: self.name,
            aggregatedBalance: self.aggregatedBalance?.toDomainModel(),
            additions: self.additions
        )
    }
}
