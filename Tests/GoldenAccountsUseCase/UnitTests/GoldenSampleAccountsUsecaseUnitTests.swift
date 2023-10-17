//
//  GoldenSampleAccountsUsecaseUnitTests.swift
//  GoldenSampleAppTests
//
//  Created by Backbase R&D B.V. on 13/10/2023.
//

import XCTest
import Foundation
import ArrangementsClient2Gen2
import AccountsJourney
import GoldenAccountsUseCase

final class GoldenSampleAccountsMappersUnitTests: XCTestCase {
    func test_UserPreferences_toDomainModel_mapping() {
        let sut = ArrangementsClient2Gen2.UserPreferences.Builder()
            .set(alias: "IamAnAlias")
            .set(visible: true)
            .set(favorite: true)
            .set(additions: ["available":"yes"])
            .build()
        
        
        let expectedOutcome = AccountsJourney.UserPreferences(alias: "IamAnAlias", visible: true, favorite: true, additions: ["available":"yes"])
        
        XCTAssertEqual(sut.toDomainModel(), expectedOutcome)
    }
    
    func test_TimeUnit_toDomainModel_mapping() {
        ArrangementsClient2Gen2.TimeUnit.allCases.forEach { timeUnit in
            switch timeUnit {
            case .m:
                XCTAssertEqual(timeUnit.toDomainModel(), AccountsJourney.TimeUnit.month)
            case .y:
                XCTAssertEqual(timeUnit.toDomainModel(), AccountsJourney.TimeUnit.year)
            case .w:
                XCTAssertEqual(timeUnit.toDomainModel(), AccountsJourney.TimeUnit.week)
            default:
                XCTAssertEqual(timeUnit.toDomainModel(), AccountsJourney.TimeUnit.day)
            }
        }
    }
    
    func test_TermDeposit_toDomainModel_mapping() {
        let sut = ArrangementsClient2Gen2.TermDeposit.Builder()
            .set(id: "sick-id")
            .set(name: "Term Depo")
            .set(currency: "USH")
            .set(displayName: "Name to Display")
            .build()
        let expectedOutput = AccountsJourney.TermDeposit(bookedBalance: nil, principalAmount: nil, accruedInterest: nil, iban: nil, bban: nil, currency: "USH", urgentTransferAllowed: nil, productNumber: nil, accountInterestRate: nil, startDate: nil, termUnit: nil, termNumber: nil, maturityDate: nil, maturityAmount: nil, autoRenewalIndicator: nil, interestPaymentFrequencyUnit: nil, interestPaymentFrequencyNumber: nil, interestSettlementAccount: nil, valueDateBalance: nil, accountHolderNames: nil, outstandingPrincipalAmount: nil, creditAccount: nil, debitAccount: nil, minimumRequiredBalance: nil, additions: nil, identifier: "sick-id", unmaskableAttributes: nil, name: "Term Depo", displayName: "Name to Display", externalTransferAllowed: nil, crossCurrencyAllowed: nil, productKindName: nil, productTypeName: nil, bankAlias: nil, sourceId: nil, visible: nil, accountOpeningDate: nil, lastUpdateDate: nil, userPreferences: nil, state: nil, parentId: nil, subArrangements: nil, financialInstitutionId: nil, lastSyncDate: nil, bankBranchCode2: nil, nextClosingDate: nil, reservedAmount: nil, remainingPeriodicTransfers: nil, overdueSince: nil, externalAccountStatus: nil, cardDetails: nil, interestDetails: nil, bankBranchCode: nil, creditLimit: nil, availableBalance: nil, minimumPayment: nil, minimumPaymentDueDate: nil)
        
        XCTAssertEqual(sut.toDomainModel(), expectedOutput)
    }
    
    func test_SavingsAccounts_toDomainModel_mapping() {
        let sut = ArrangementsClient2Gen2.SavingsAccount.Builder()
            .set(id: "savings-account")
            .set(town: "Amsterdam")
            .set(visible: true)
            .set(availableBalance: "-2.00,98")
            .build()
        
        let expectedOutcome = AccountsJourney.SavingsAccount(bookedBalance: nil, availableBalance: "-2.00,98", accruedInterest: nil, iban: nil, bban: nil, currency: nil, urgentTransferAllowed: nil, bic: nil, bankBranchCode: nil, bankBranchCode2: nil, accountInterestRate: nil, minimumRequiredBalance: nil, startDate: nil, termUnit: nil, termNumber: nil, maturityDate: nil, maturityAmount: nil, autoRenewalIndicator: nil, interestPaymentFrequencyUnit: nil, interestPaymentFrequencyNumber: nil, principalAmount: nil, interestSettlementAccount: nil, accountHolderNames: nil, valueDateBalance: nil, accountHolderAddressLine1: nil, accountHolderAddressLine2: nil, accountHolderStreetName: nil, town: "Amsterdam", postCode: nil, countrySubDivision: nil, accountHolderCountry: nil, creditAccount: nil, debitAccount: nil, additions: nil, identifier: "savings-account", unmaskableAttributes: nil, name: nil, displayName: nil, externalTransferAllowed: nil, crossCurrencyAllowed: nil, productKindName: nil, productTypeName: nil, bankAlias: nil, sourceId: nil, visible: true, accountOpeningDate: nil, lastUpdateDate: nil, userPreferences: nil, state: nil, parentId: nil, subArrangements: nil, financialInstitutionId: nil, lastSyncDate: nil, nextClosingDate: nil, reservedAmount: nil, remainingPeriodicTransfers: nil, overdueSince: nil, externalAccountStatus: nil, cardDetails: nil, interestDetails: nil)
        
        XCTAssertEqual(sut.toDomainModel(), expectedOutcome)
    }
    
    func test_StateItem_toDomainModel_mapping() {
        let sut = ArrangementsClient2Gen2.StateItem.Builder()
            .set(state: "my-local-state")
            .set(externalStateId: "external-id")
            .set(additions: ["additional-info":"happy"])
            .build()
        
        let expectedOutcome = AccountsJourney.ProductState(externalStateId: "external-id", state: "my-local-state", additions: ["additional-info":"happy"])
        
        XCTAssertEqual(sut.toDomainModel(), expectedOutcome)
    }
    
    func test_MaskableAttributes_toDomainModel_mapping() {
        ArrangementsClient2Gen2.MaskableAttribute.allCases.forEach { maskableAttribute in
            switch maskableAttribute {
            case .bban:
                XCTAssertEqual(maskableAttribute.toDomainModel(), AccountsJourney.MaskableAttribute.bban)
            case .iban:
                XCTAssertEqual(maskableAttribute.toDomainModel(), AccountsJourney.MaskableAttribute.iban)
            default:
                XCTAssertEqual(maskableAttribute.toDomainModel(), AccountsJourney.MaskableAttribute.number)
                
            }
        }
    }
    
    func test_Loan_toDomainModel_mapping() {
        let sut = ArrangementsClient2Gen2.Loan.Builder()
            .set(id: "loan-id")
            .set(bookedBalance: "4.000")
            .set(currency: "WIERD")
            .build()
        let expectedOutput = AccountsJourney.Loan(bookedBalance: "4.000", principalAmount: nil, currency: "WIERD", urgentTransferAllowed: nil, productNumber: nil, accountInterestRate: nil, termUnit: nil, termNumber: nil, outstandingPrincipalAmount: nil, monthlyInstalmentAmount: nil, amountInArrear: nil, interestSettlementAccount: nil, accruedInterest: nil, accountHolderNames: nil, maturityDate: nil, valueDateBalance: nil, creditAccount: nil, debitAccount: nil, iban: nil, bban: nil, additions: nil, identifier: "loan-id", unmaskableAttributes: nil, name: nil, displayName: nil, externalTransferAllowed: nil, crossCurrencyAllowed: nil, productKindName: nil, productTypeName: nil, bankAlias: nil, sourceId: nil, visible: nil, accountOpeningDate: nil, lastUpdateDate: nil, userPreferences: nil, state: nil, parentId: nil, subArrangements: nil, financialInstitutionId: nil, lastSyncDate: nil, bankBranchCode2: nil, nextClosingDate: nil, reservedAmount: nil, remainingPeriodicTransfers: nil, overdueSince: nil, externalAccountStatus: nil, cardDetails: nil, interestDetails: nil, bankBranchCode: nil)
        XCTAssertEqual(sut.toDomainModel(), expectedOutput)
    }
    
    func test_InvestmentAccount_toDomainModel_mapping() {
        let sut = ArrangementsClient2Gen2.InvestmentAccount.Builder()
            .set(id: "investment-account")
            .set(visible: true)
            .set(parentId: "parent-id")
            .set(name: "Investment account")
            .build()
        
        let expectedOutcome = AccountsJourney.InvestmentAccount(currentInvestmentValue: nil, currency: nil, urgentTransferAllowed: nil, productNumber: nil, iban: nil, bban: nil, additions: nil, identifier: "investment-account", unmaskableAttributes: nil, name: "Investment account", displayName: nil, externalTransferAllowed: nil, crossCurrencyAllowed: nil, productKindName: nil, productTypeName: nil, bankAlias: nil, sourceId: nil, visible: true, accountOpeningDate: nil, lastUpdateDate: nil, userPreferences: nil, state: nil, parentId: "parent-id", subArrangements: nil, financialInstitutionId: nil, lastSyncDate: nil, bankBranchCode2: nil, nextClosingDate: nil, reservedAmount: nil, remainingPeriodicTransfers: nil, overdueSince: nil, externalAccountStatus: nil, cardDetails: nil, interestDetails: nil, accountHolderNames: nil)
        
        XCTAssertEqual(sut.toDomainModel(), expectedOutcome)
    }
    
    func test_InterestDetails_toDomainModel_mapping() {
        let sut = ArrangementsClient2Gen2.InterestDetails.Builder()
            .set(additions: [:])
            .set(dividendWithheldYTD: "4.000")
            .set(cashAdvanceInterestRate: 50.00)
            .build()
        
        let expectedOutcome = AccountsJourney.InterestDetails(additions: [:], lastYearAccruedInterest: nil, dividendWithheldYTD: "4.000", annualPercentageYield: nil, cashAdvanceInterestRate: 50.00, penaltyInterestRate: nil)
        
        XCTAssertEqual(sut.toDomainModel(), expectedOutcome)
    }
    
    func test_DebitCard_toDomainModel_mapping() {
        let sut = ArrangementsClient2Gen2.DebitCard
            .Builder(debitCardsItems: [
                .Builder()
                .set(number: "CardNumber")
                .set(cardStatus: "Active")
                .set(expiryDate: "Future")
                .set(cardId: "AwesomeId")
                .set(cardholderName: "It's Mine")
                .set(cardType: "Flashy Card")
                .set(additions: [:])
                .build()
            ]
            ).set(name: "Serious Cards")
            .build()
        let expectedDebitCard = AccountsJourney.DebitCardItem(number: "CardNumber", expiryDate: "Future", cardId: "AwesomeId", cardholderName: "It's Mine", cardType: "Flashy Card", cardStatus: "Active", additions: [:])
        
        let expectedOutcome = AccountsJourney.DebitCard(debitCardsItems: [expectedDebitCard], name: "Serious Cards")
        XCTAssertEqual(sut.toDomainModel(), expectedOutcome)
    }
    
}
