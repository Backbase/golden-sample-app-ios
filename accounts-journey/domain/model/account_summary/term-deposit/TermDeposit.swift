//
//  TermDeposit.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 12/10/2023.
//

import Foundation

extension AccountsJourney {
    /// Term deposit account type.
    public struct TermDeposit: Equatable {
        /// Booked balance
        public let bookedBalance: String?
        /// Principle amount
        public let principalAmount: Double?
        /// Accrued interest if available
        public let accruedInterest: Double?
        /// Specifying the IBAN - IBAN is short for International Bank Account Number of the account.
        public let iban: String?
        /// Specifying the BBAN of the account - BBAN is short for Basic Bank Account Number.
        /// It represents a country-specific bank account number.
        public let bban: String?
        /// The alpha-3 code (complying with ISO 4217) of the currency that qualifies the amount.
        public let currency: String?
        /// Defines if urgent transfer is allowed.
        public let urgentTransferAllowed: Bool?
        /// The number identifying the contract.
        public let productNumber: String?
        /// The annualized cost of credit or debt-capital computed as the percentage ratio of interest to the principal.
        public let accountInterestRate: Double?
        /// Start date
        public let startDate: Date?
        /// Term unit
        public let termUnit: TimeUnit?
        /// The number of times interest rate is paid on the settlement account.
        public let termNumber: Double?
        /// End term of a holding period.
        public let maturityDate: Date?
        /// Amount payable at the end of a holding period of a product (maturity date).
        /// For deposit all of the interest is usually paid at maturity date (IF the term is shorter then one year).
        public let maturityAmount: Double?
        /// Indicates whether or not an arrangement is to be continued after maturity automatically.
        /// Usually the product is renewed using the same principal and term unless renegotiation has taken place prior to expiration.
        public let autoRenewalIndicator: Bool?
        /// Interest payment frequency unit
        public let interestPaymentFrequencyUnit: TimeUnit?
        /// Interest payment frequency number
        public let interestPaymentFrequencyNumber: Double?
        /// Account that provides quick access to accumulated cash to facilitate daily settlements with other businesses.
        public let interestSettlementAccount: String?
        /// The balance of the account on a specific date that needs to be used for the calculation of interest.
        /// If no date is specified (like for the book date balance) the current date can be assumed.
        public let valueDateBalance: Double?
        /// Party(s) with a relationship to the account.
        public let accountHolderNames: String?
        /// This property is the value date balance of the arrangement.
        public let outstandingPrincipalAmount: Double?
        /// Indicator whether or not the arrangement can be used in payment orders as credit account.
        public let creditAccount: Bool?
        /// Indicator whether or not the arrangement can be used in payment orders as debit account.
        public let debitAccount: Bool?
        /// Minimum amount that a customer must have in an account in order to receive some sort of service,
        /// such as keeping the account open or receive interest.
        public let minimumRequiredBalance: Double?
        /// Additional fields
        public let additions: [String: String]?
        /// Reference to the product of which the arrangement is an instantiation.
        public let identifier: String?
        /// An optional list of the maskable attributes that can be unmasked.
        public let unmaskableAttributes: [MaskableAttribute]?
        /// Account name
        public let name: String?
        /// Represents an arrangement by it's correct naming identifier. It could be account alias or user alias depending on the journey
        /// selected by the financial institution. If none of those is set, the arrangement name will be used.
        public let displayName: String?
        /// Defines if transfer to another party is allowed.
        public let externalTransferAllowed: Bool?
        /// Defines if cross currency transfer is allowed.
        public let crossCurrencyAllowed: Bool?
        /// The label/name that is used for the respective product kind.
        public let productKindName: String?
        /// The label/name that is used to label a specific product type.
        public let productTypeName: String?
        /// The name that can be assigned by the bank to label the arrangement.
        public let bankAlias: String?
        /// Indicate if the account is regular or external.
        public let sourceId: String?
        /// Indicator whether to show or hide the arrangement on the view.
        public let visible: Bool?
        /// Account opening date
        public let accountOpeningDate: Date?
        /// Last date of parameter update for the arrangement.
        public let lastUpdateDate: Date?
        /// User preferences
        public let userPreferences: UserPreferences?
        /// State of the account
        public let state: ProductState?
        /// Reference to the parent of the arrangement.
        public let parentId: String?
        /// Sub-arrangements of the account.
        public let subArrangements: [BaseProduct]?
        /// Financial institution ID.
        public let financialInstitutionId: Int64?
        /// Last synchronization datetime.
        public let lastSyncDate: Date?
        /// Another country-specific bank identification number or code:
        /// the Fedwire Routing Number in the US or another country-specific identifier.
        public let bankBranchCode2: String?
        /// The last day of the forthcoming billing cycle.
        public let nextClosingDate: Date?
        /// The reservation of a portion of a credit or debit balance for the cost of services not yet rendered.
        public let reservedAmount: Double?
        /// The limitation in periodic saving transfers or withdrawals. In the case of the US,
        /// Regulation D enables for a maximum of 6 monthly savings transfers or withdrawals.
        public let remainingPeriodicTransfers: Double?
        /// The date in which the arrangement has been overdue since.
        public let overdueSince: Date?
        /// Synchronization statuses an account can have on the provider side after it has been aggregated.
        public let externalAccountStatus: String?
        /// Card details
        public let cardDetails: CardDetails?
        /// Interest Details
        public let interestDetails: InterestDetails?
        /// This property is to accommodate additional country specific fields like Sort Code in UK.
        public let bankBranchCode: String?
        /// Credit limit for the account
        public let creditLimit: String?
        /// Available balance
        public let availableBalance: String?
        /// The minimum payment set a percentage of balance, or a fixed cash amount.
        public let minimumPayment: Double?
        /// Minimum Payment Due Date shown on your monthly statement to remain in good standing.
        public let minimumPaymentDueDate: Date?
        
        /// Create a new `TermDeposit` object.
        /// - Parameters:
        ///   - bookedBalance: Optional bookedBalance. Defaults to `nil`
        ///   - principalAmount: Optional principalAmount. Defaults to `nil`
        ///   - accruedInterest: Optional accruedInterest. Defaults to `nil`
        ///   - iban: Optional iban. Defaults to `nil`
        ///   - bban: Optional bban. Defaults to `nil`
        ///   - currency: Optional currency. Defaults to `nil`
        ///   - urgentTransferAllowed: Optional urgentTransferAllowed. Defaults to `nil`
        ///   - productNumber: Optional productNumber. Defaults to `nil`
        ///   - accountInterestRate: Optional accountInterestRate. Defaults to `nil`
        ///   - startDate: Optional startDate. Defaults to `nil`
        ///   - termUnit: Optional termUnit. Defaults to `nil`
        ///   - termNumber: Optional termNumber. Defaults to `nil`
        ///   - maturityDate: Optional maturityDate. Defaults to `nil`
        ///   - maturityAmount: Optional maturityAmount. Defaults to `nil`
        ///   - autoRenewalIndicator: Optional autoRenewalIndicator. Defaults to `nil`
        ///   - interestPaymentFrequencyUnit: Optional interestPaymentFrequencyUnit. Defaults to `nil`
        ///   - interestPaymentFrequencyNumber: Optional interestPaymentFrequencyNumber. Defaults to `nil`
        ///   - interestSettlementAccount: Optional interestSettlementAccount. Defaults to `nil`
        ///   - valueDateBalance: Optional valueDateBalance. Defaults to `nil`
        ///   - accountHolderNames: Optional accountHolderNames. Defaults to `nil`
        ///   - outstandingPrincipalAmount: Optional outstandingPrincipalAmount. Defaults to `nil`
        ///   - creditAccount: Optional creditAccount. Defaults to `nil`
        ///   - debitAccount: Optional debitAccount. Defaults to `nil`
        ///   - minimumRequiredBalance: Optional minimumRequiredBalance. Defaults to `nil`
        ///   - additions: Optional additions. Defaults to `nil`
        ///   - identifier: Optional identifier. Defaults to `nil`
        ///   - unmaskableAttributes: Optional unmaskableAttributes. Defaults to `nil`
        ///   - name: Optional name. Defaults to `nil`
        ///   - displayName: Optional displayName. Defaults to `nil`
        ///   - externalTransferAllowed: Optional externalTransferAllowed. Defaults to `nil`
        ///   - crossCurrencyAllowed: Optional crossCurrencyAllowed. Defaults to `nil`
        ///   - productKindName: Optional productKindName. Defaults to `nil`
        ///   - productTypeName: Optional productTypeName. Defaults to `nil`
        ///   - bankAlias: Optional bankAlias. Defaults to `nil`
        ///   - sourceId: Optional sourceId. Defaults to `nil`
        ///   - visible: Optional visible. Defaults to `nil`
        ///   - accountOpeningDate: Optional accountOpeningDate. Defaults to `nil`
        ///   - lastUpdateDate: Optional lastUpdateDate. Defaults to `nil`
        ///   - userPreferences: Optional userPreferences. Defaults to `nil`
        ///   - state: Optional state. Defaults to `nil`
        ///   - parentId: Optional parentId. Defaults to `nil`
        ///   - subArrangements: Optional subArrangements. Defaults to `nil`
        ///   - financialInstitutionId: Optional financialInstitutionId. Defaults to `nil`
        ///   - lastSyncDate: Optional lastSyncDate. Defaults to `nil`
        ///   - bankBranchCode2: Optional bankBranchCode2. Defaults to `nil`
        ///   - nextClosingDate: The last day of the forthcoming billing cycle.
        ///   - reservedAmount: The reservation of a portion of a credit or debit balance for the cost of services not yet rendered.
        ///   - remainingPeriodicTransfers: The limitation in periodic saving transfers or withdrawals. In the case of the US,
        ///   Regulation D enables for a maximum of 6 monthly savings transfers or withdrawals.
        ///   - overdueSince: The date in which the arrangement has been overdue since.
        ///   - externalAccountStatus: Synchronization statuses an account can have on the provider side after it has been aggregated.
        ///   - cardDetails: Card details
        ///   - interestDetails: Interest Details
        ///   - bankBranchCode: This property is to accommodate additional country specific fields like Sort Code in UK.
        ///   - creditLimit: Credit limit for the account
        ///   - availableBalance: Available balance
        ///   - minimumPayment: The minimum payment set a percentage of balance, or a fixed cash amount.
        ///   - minimumPaymentDueDate: Minimum Payment Due Date shown on your monthly statement to remain in good standing.
        public init(
            // swiftlint:disable:previous function_body_length
            bookedBalance: String? = nil,
            principalAmount: Double? = nil,
            accruedInterest: Double? = nil,
            iban: String? = nil,
            bban: String? = nil,
            currency: String? = nil,
            urgentTransferAllowed: Bool? = nil,
            productNumber: String? = nil,
            accountInterestRate: Double? = nil,
            startDate: Date? = nil,
            termUnit: TimeUnit? = nil,
            termNumber: Double? = nil,
            maturityDate: Date? = nil,
            maturityAmount: Double? = nil,
            autoRenewalIndicator: Bool? = nil,
            interestPaymentFrequencyUnit: TimeUnit? = nil,
            interestPaymentFrequencyNumber: Double? = nil,
            interestSettlementAccount: String? = nil,
            valueDateBalance: Double? = nil,
            accountHolderNames: String? = nil,
            outstandingPrincipalAmount: Double? = nil,
            creditAccount: Bool? = nil,
            debitAccount: Bool? = nil,
            minimumRequiredBalance: Double? = nil,
            additions: [String: String]? = nil,
            identifier: String? = nil,
            unmaskableAttributes: [MaskableAttribute]? = nil,
            name: String? = nil,
            displayName: String? = nil,
            externalTransferAllowed: Bool? = nil,
            crossCurrencyAllowed: Bool? = nil,
            productKindName: String? = nil,
            productTypeName: String? = nil,
            bankAlias: String? = nil,
            sourceId: String? = nil,
            visible: Bool? = nil,
            accountOpeningDate: Date? = nil,
            lastUpdateDate: Date? = nil,
            userPreferences: UserPreferences? = nil,
            state: ProductState? = nil,
            parentId: String? = nil,
            subArrangements: [BaseProduct]? = nil,
            financialInstitutionId: Int64? = nil,
            lastSyncDate: Date? = nil,
            bankBranchCode2: String? = nil,
            nextClosingDate: Date? = nil,
            reservedAmount: Double? = nil,
            remainingPeriodicTransfers: Double? = nil,
            overdueSince: Date? = nil,
            externalAccountStatus: String? = nil,
            cardDetails: CardDetails? = nil,
            interestDetails: InterestDetails? = nil,
            bankBranchCode: String? = nil,
            creditLimit: String? = nil,
            availableBalance: String? = nil,
            minimumPayment: Double? = nil,
            minimumPaymentDueDate: Date? = nil
        ) {
            self.bookedBalance = bookedBalance
            self.principalAmount = principalAmount
            self.accruedInterest = accruedInterest
            self.iban = iban
            self.bban = bban
            self.currency = currency
            self.urgentTransferAllowed = urgentTransferAllowed
            self.productNumber = productNumber
            self.accountInterestRate = accountInterestRate
            self.startDate = startDate
            self.termUnit = termUnit
            self.termNumber = termNumber
            self.maturityDate = maturityDate
            self.maturityAmount = maturityAmount
            self.autoRenewalIndicator = autoRenewalIndicator
            self.interestPaymentFrequencyUnit = interestPaymentFrequencyUnit
            self.interestPaymentFrequencyNumber = interestPaymentFrequencyNumber
            self.interestSettlementAccount = interestSettlementAccount
            self.valueDateBalance = valueDateBalance
            self.accountHolderNames = accountHolderNames
            self.outstandingPrincipalAmount = outstandingPrincipalAmount
            self.creditAccount = creditAccount
            self.debitAccount = debitAccount
            self.minimumRequiredBalance = minimumRequiredBalance
            self.additions = additions
            self.identifier = identifier
            self.unmaskableAttributes = unmaskableAttributes
            self.name = name
            self.displayName = displayName
            self.externalTransferAllowed = externalTransferAllowed
            self.crossCurrencyAllowed = crossCurrencyAllowed
            self.productKindName = productKindName
            self.productTypeName = productTypeName
            self.bankAlias = bankAlias
            self.sourceId = sourceId
            self.visible = visible
            self.accountOpeningDate = accountOpeningDate
            self.lastUpdateDate = lastUpdateDate
            self.userPreferences = userPreferences
            self.state = state
            self.parentId = parentId
            self.subArrangements = subArrangements
            self.financialInstitutionId = financialInstitutionId
            self.lastSyncDate = lastSyncDate
            self.bankBranchCode2 = bankBranchCode2
            self.nextClosingDate = nextClosingDate
            self.reservedAmount = reservedAmount
            self.remainingPeriodicTransfers = remainingPeriodicTransfers
            self.overdueSince = overdueSince
            self.externalAccountStatus = externalAccountStatus
            self.cardDetails = cardDetails
            self.interestDetails = interestDetails
            self.bankBranchCode = bankBranchCode
            self.creditLimit = creditLimit
            self.availableBalance = availableBalance
            self.minimumPayment = minimumPayment
            self.minimumPaymentDueDate = minimumPaymentDueDate
        }
    }
}
