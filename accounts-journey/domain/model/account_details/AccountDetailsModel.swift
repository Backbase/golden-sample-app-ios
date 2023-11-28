//
//  AccountDetails.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 28/11/2023.
//

import Foundation

extension AccountsJourney {
    public struct AccountDetails {
        public let id: String
        public let productId: String
        public let productKindName: String?
        public let legalEntityIds: [String]?
        public let productTypeName: String?
        public let externalProductId: String?
        public let externalArrangementId: String?
        public let userPreferences: AccountUserPreferences?
        public let product: ExternalProductItem?
        public let state: ProductState?
        public let parentId: String?
        public let currency: String
        public let name: String?
        public let bookedBalance: Double?
        public let availableBalance: Double?
        public let creditLimit: Double?
        public let IBAN: String?
        public let BBAN: String?
        public let BIC: String?
        public let externalTransferAllowed: Bool?
        public let urgentTransferAllowed: Bool?
        public let accruedInterest: Double?
        public let number: String?
        public let principalAmount: Double?
        public let currentInvestmentValue: Double?
        public let productNumber: String?
        public let bankBranchCode: String?
        public let bankBranchCode2: String?
        public let accountOpeningDate: Date?
        public let accountInterestRate: Double?
        public let valueDateBalance: Double?
        public let creditLimitUsage: Double?
        public let creditLimitInterestRate: Double?
        public let creditLimitExpiryDate: Date?
        public let startDate: Date?
        public let termUnit: TimeUnit?
        public let termNumber: Double?
        public let interestPaymentFrequencyUnit: TimeUnit?
        public let interestPaymentFrequencyNumber: Double?
        public let maturityDate: Date?
        public let maturityAmount: Double?
        public let autoRenewalIndicator: Bool?
        public let interestSettlementAccount: String?
        public let outstandingPrincipalAmount: Double?
        public let monthlyInstalmentAmount: Double?
        public let amountInArrear: Double?
        public let minimumRequiredBalance: Double?
        public let creditCardAccountNumber: String?
        public let validThru: Date?
        public let applicableInterestRate: Double?
        public let remainingCredit: Double?
        public let outstandingPayment: Double?
        public let minimumPayment: Double?
        public let minimumPaymentDueDate: Date?
        public let totalInvestmentValue: Double?
        public let debitCards: [DebitCardItem]?
        public let accountHolderAddressLine1: String?
        public let accountHolderAddressLine2: String?
        public let accountHolderStreetName: String?
        public let town: String?
        public let postCode: String?
        public let countrySubDivision: String?
        public let accountHolderNames: String?
        public let accountHolderCountry: String?
        public let creditAccount: Bool?
        public let debitAccount: Bool?
        public let lastUpdateDate: Date?
        public let bankAlias: String?
        public let sourceId: String?
        public let externalStateId: String?
        public let externalParentId: String?
        public let financialInstitutionId: Int64?
        public let lastSyncDate: Date?
        public let additions: [String: String]?
        public let unmaskableAttributes: [MaskableAttribute]?
        public let displayName: String?
        public let cardDetails: CardDetails?
        public let interestDetails: InterestDetails?
        public let reservedAmount: Double?
        public let remainingPeriodicTransfers: Double?
        public let nextClosingDate: Date?
        public let overdueSince: Date?
        public let externalAccountStatus: String?
        
        public init(
            id: String,
            productId: String,
            productKindName: String? = nil,
            legalEntityIds: [String]? = nil,
            productTypeName: String? = nil,
            externalProductId: String? = nil,
            externalArrangementId: String? = nil,
            userPreferences: AccountUserPreferences? = nil,
            product: ExternalProductItem? = nil,
            state: ProductState? = nil,
            parentId: String? = nil,
            currency: String,
            name: String? = nil,
            bookedBalance: Double? = nil,
            availableBalance: Double? = nil,
            creditLimit: Double? = nil,
            IBAN: String? = nil,
            BBAN: String? = nil,
            BIC: String? = nil,
            externalTransferAllowed: Bool? = nil,
            urgentTransferAllowed: Bool? = nil,
            accruedInterest: Double? = nil,
            number: String? = nil,
            principalAmount: Double? = nil,
            currentInvestmentValue: Double? = nil,
            productNumber: String? = nil,
            bankBranchCode: String? = nil,
            bankBranchCode2: String? = nil,
            accountOpeningDate: Date? = nil,
            accountInterestRate: Double? = nil,
            valueDateBalance: Double? = nil,
            creditLimitUsage: Double? = nil,
            creditLimitInterestRate: Double? = nil,
            creditLimitExpiryDate: Date? = nil,
            startDate: Date? = nil,
            termUnit: TimeUnit? = nil,
            termNumber: Double? = nil,
            interestPaymentFrequencyUnit: TimeUnit? = nil,
            interestPaymentFrequencyNumber: Double? = nil,
            maturityDate: Date? = nil,
            maturityAmount: Double? = nil,
            autoRenewalIndicator: Bool? = nil,
            interestSettlementAccount: String? = nil,
            outstandingPrincipalAmount: Double? = nil,
            monthlyInstalmentAmount: Double? = nil,
            amountInArrear: Double? = nil,
            minimumRequiredBalance: Double? = nil,
            creditCardAccountNumber: String? = nil,
            validThru: Date? = nil,
            applicableInterestRate: Double? = nil,
            remainingCredit: Double? = nil,
            outstandingPayment: Double? = nil,
            minimumPayment: Double? = nil,
            minimumPaymentDueDate: Date? = nil,
            totalInvestmentValue: Double? = nil,
            debitCards: [DebitCardItem]? = nil,
            accountHolderAddressLine1: String? = nil,
            accountHolderAddressLine2: String? = nil,
            accountHolderStreetName: String? = nil,
            town: String? = nil,
            postCode: String? = nil,
            countrySubDivision: String? = nil,
            accountHolderNames: String? = nil,
            accountHolderCountry: String? = nil,
            creditAccount: Bool? = nil,
            debitAccount: Bool? = nil,
            lastUpdateDate: Date? = nil,
            bankAlias: String? = nil,
            sourceId: String? = nil,
            externalStateId: String? = nil,
            externalParentId: String? = nil,
            financialInstitutionId: Int64? = nil,
            lastSyncDate: Date? = nil,
            additions: [String: String]? = nil,
            unmaskableAttributes: [MaskableAttribute]? = nil,
            displayName: String? = nil,
            cardDetails: CardDetails? = nil,
            interestDetails: InterestDetails? = nil,
            reservedAmount: Double? = nil,
            remainingPeriodicTransfers: Double? = nil,
            nextClosingDate: Date? = nil,
            overdueSince: Date? = nil,
            externalAccountStatus: String? = nil) {
                self.id = id
                self.productId = productId
                self.productKindName = productKindName
                self.legalEntityIds = legalEntityIds
                self.productTypeName = productTypeName
                self.externalProductId = externalProductId
                self.externalArrangementId = externalArrangementId
                self.userPreferences = userPreferences
                self.product = product
                self.state = state
                self.parentId = parentId
                self.currency = currency
                self.name = name
                self.bookedBalance = bookedBalance
                self.availableBalance = availableBalance
                self.creditLimit = creditLimit
                self.IBAN = IBAN
                self.BBAN = BBAN
                self.BIC = BIC
                self.externalTransferAllowed = externalTransferAllowed
                self.urgentTransferAllowed = urgentTransferAllowed
                self.accruedInterest = accruedInterest
                self.number = number
                self.principalAmount = principalAmount
                self.currentInvestmentValue = currentInvestmentValue
                self.productNumber = productNumber
                self.bankBranchCode = bankBranchCode
                self.bankBranchCode2 = bankBranchCode2
                self.accountOpeningDate = accountOpeningDate
                self.accountInterestRate = accountInterestRate
                self.valueDateBalance = valueDateBalance
                self.creditLimitUsage = creditLimitUsage
                self.creditLimitInterestRate = creditLimitInterestRate
                self.creditLimitExpiryDate = creditLimitExpiryDate
                self.startDate = startDate
                self.termUnit = termUnit
                self.termNumber = termNumber
                self.interestPaymentFrequencyUnit = interestPaymentFrequencyUnit
                self.interestPaymentFrequencyNumber = interestPaymentFrequencyNumber
                self.maturityDate = maturityDate
                self.maturityAmount = maturityAmount
                self.autoRenewalIndicator = autoRenewalIndicator
                self.interestSettlementAccount = interestSettlementAccount
                self.outstandingPrincipalAmount = outstandingPrincipalAmount
                self.monthlyInstalmentAmount = monthlyInstalmentAmount
                self.amountInArrear = amountInArrear
                self.minimumRequiredBalance = minimumRequiredBalance
                self.creditCardAccountNumber = creditCardAccountNumber
                self.validThru = validThru
                self.applicableInterestRate = applicableInterestRate
                self.remainingCredit = remainingCredit
                self.outstandingPayment = outstandingPayment
                self.minimumPayment = minimumPayment
                self.minimumPaymentDueDate = minimumPaymentDueDate
                self.totalInvestmentValue = totalInvestmentValue
                self.debitCards = debitCards
                self.accountHolderAddressLine1 = accountHolderAddressLine1
                self.accountHolderAddressLine2 = accountHolderAddressLine2
                self.accountHolderStreetName = accountHolderStreetName
                self.town = town
                self.postCode = postCode
                self.countrySubDivision = countrySubDivision
                self.accountHolderNames = accountHolderNames
                self.accountHolderCountry = accountHolderCountry
                self.creditAccount = creditAccount
                self.debitAccount = debitAccount
                self.lastUpdateDate = lastUpdateDate
                self.bankAlias = bankAlias
                self.sourceId = sourceId
                self.externalStateId = externalStateId
                self.externalParentId = externalParentId
                self.financialInstitutionId = financialInstitutionId
                self.lastSyncDate = lastSyncDate
                self.additions = additions
                self.unmaskableAttributes = unmaskableAttributes
                self.displayName = displayName
                self.cardDetails = cardDetails
                self.interestDetails = interestDetails
                self.reservedAmount = reservedAmount
                self.remainingPeriodicTransfers = remainingPeriodicTransfers
                self.nextClosingDate = nextClosingDate
                self.overdueSince = overdueSince
                self.externalAccountStatus = externalAccountStatus
            }
    }
}
