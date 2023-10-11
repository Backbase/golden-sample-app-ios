//
//  GeneralAccount.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 11/10/2023.
//

import Foundation

/// General account type.
 struct GeneralAccount: Equatable {
    /// Booked balance
     let bookedBalance: String?
    /// Available balance
     let availableBalance: String?
    /// Credit limit
     let creditLimit: String?
    /// Specifying the IBAN - IBAN is short for International Bank Account Number of the account.
     let iban: String?
    /// Specifying the BBAN of the account - BBAN is short for Basic Bank Account Number.
    /// It represents a country-specific bank account number.
     let bban: String?
    /// The alpha-3 code (complying with ISO 4217) of the currency that qualifies the amount.
     let currency: String?
    /// Defines if urgent transfer is allowed.
     let urgentTransferAllowed: Bool?
    /// Bank Identifier Code - international bank code that identifies particular banks worldwide.
     let bic: String?
    /// This property is to accommodate additional country specific fields like Sort Code in UK.
     let bankBranchCode: String?
    /// Another country-specific bank identification number or code:
    /// the Fedwire Routing Number in the US or another country-specific identifier.
     let bankBranchCode2: String?
    /// The annualized cost of credit or debt-capital computed as the percentage ratio of interest to the principal.
     let accountInterestRate: Double?
    /// The balance of the account on a specific date that needs to be used for the calculation of interest.
    /// If no date is specified (like for the book date balance) the current date can be assumed.
     let valueDateBalance: Double?
    /// Monetary amount of the used overdraft.
     let creditLimitUsage: Double?
    /// Overdraft Interest is an interest applied to the account for any time throughout the month when the account is overdrawn.
     let creditLimitInterestRate: Double?
    /// The date after which overdraft will no longer be available to the account (renewed automatically or cancelled).
     let creditLimitExpiryDate: Date?
    /// Accrued interest
     let accruedInterest: Double?
    /// Debit card items
     let debitCardsItems: [DebitCardItem]
    /// Start date
     let startDate: Date?
    /// Minimum amount that a customer must have in an account in order to receive some sort of service,
    /// such as keeping the account open or receive interest.
     let minimumRequiredBalance: Double?
    /// Address of the Payer/Payee - Alternate address line for the account.
     let accountHolderAddressLine1: String?
    /// Address of the Payer/Payee - Alternate address line for the account.
     let accountHolderAddressLine2: String?
    /// Street name of the Payer/Payee - Alternate street name for the account.
     let accountHolderStreetName: String?
    /// Town of the Payer/Payee - Alternate town for the account.
     let town: String?
    /// Post code.
     let postCode: String?
    /// County sub-division.
     let countrySubDivision: String?
    /// Party(s) with a relationship to the account.
     let accountHolderNames: String?
    /// Country of the account holder
     let accountHolderCountry: String?
    /// First 6 and/or last 4 digits of a Payment card. All other digits will/to be masked.
    /// Be aware that using card number differently is potential PCI risk.
     let number: String?
    /// Card number of the account if applicable.
     let cardNumber: Double?
    /// The number of the account the credit card transactions settle on (so actually the reference to the settlement account of the card)
     let creditCardAccountNumber: String?
    /// Expiration date of a credit card, after which is no longer valid.
     let validThru: Date?
    /// The interest rate or rates which would be used for a particular arrangement.
     let applicableInterestRate: Double?
    /// Remaining credit of the account
     let remainingCredit: Double?
    /// Outstanding payment
     let outstandingPayment: Double?
    /// The minimum payment set a percentage of balance, or a fixed cash amount.
     let minimumPayment: Double?
    /// Minimum Payment Due Date shown on your monthly statement to remain in good standing.
     let minimumPaymentDueDate: Date?
    /// Current investment value.
     let currentInvestmentValue: String?
    /// The number identifying the contract.
     let productNumber: String?
    /// Principal amount
     let principalAmount: Double?
    /// Term unit.
     let termUnit: TimeUnit?
    /// The number of times interest rate is paid on the settlement account.
     let termNumber: Double?
    /// This property is the value date balance of the arrangement.
     let outstandingPrincipalAmount: Double?
    /// A fixed payment amount paid by a borrower to the bank at a specified date each calendar month.
     let monthlyInstalmentAmount: Double?
    /// The part of a debt that is overdue after missing one or more required payments.
    /// The amount of the arrears is the amount accrued from the date on which the first missed payment was due.
     let amountInArrear: Double?
    /// Account that provides quick access to accumulated cash to facilitate daily settlements with other businesses.
     let interestSettlementAccount: String?
    /// End term of a holding period.
     let maturityDate: Date?
    /// Amount payable at the end of a holding period of a product (maturity date).
    /// For deposit all of the interest is usually paid at maturity date (IF the term is shorter then one year).
     let maturityAmount: Double?
    /// Indicates whether or not an arrangement is to be continued after maturity automatically.
    /// Usually the product is renewed using the same principal and term unless renegotiation has taken place prior to expiration.
     let autoRenewalIndicator: Bool?
    /// Interest payment frequency unit
     let interestPaymentFrequencyUnit: TimeUnit?
    /// Interest payment frequency number
     let interestPaymentFrequencyNumber: Double?
    /// Indicator whether or not the arrangement can be used in payment orders as credit account.
     let creditAccount: Bool?
    /// Indicator whether or not the arrangement can be used in payment orders as debit account.
     let debitAccount: Bool?
    /// Additional fields
     let additions: [String: String]?
    /// Reference to the product of which the arrangement is an instantiation.
     let identifier: String?
    /// An optional list of the maskable attributes that can be unmasked.
     let unmaskableAttributes: [MaskableAttribute]?
    /// Name of the account
     let name: String?
    /// Represents an arrangement by it's correct naming identifier. It could be account alias or user alias depending on the journey
    /// selected by the financial institution. If none of those is set, the arrangement name will be used.
     let displayName: String?
    /// Defines if transfer to another party is allowed.
     let externalTransferAllowed: Bool?
    /// Defines if cross currency transfer is allowed.
     let crossCurrencyAllowed: Bool?
    /// The label/name that is used for the respective product kind.
     let productKindName: String?
    /// The label/name that is used to label a specific product type.
     let productTypeName: String?
    /// The name that can be assigned by the bank to label the arrangement.
     let bankAlias: String?
    /// Indicate if the account is regular or external.
     let sourceId: String?
    /// Indicator whether to show or hide the arrangement on the view.
     let visible: Bool?
    /// Account opening date
     let accountOpeningDate: Date?
    /// Last date of parameter update for the arrangement.
     let lastUpdateDate: Date?
    /// User preferences specifically set by the user.
     let userPreferences: UserPreferences?
    /// State of the account
     let state: ProductState?
    /// Reference to the parent of the arrangement.
     let parentId: String?
    /// Sub-arrangements.
     let subArrangements: [BaseProduct]?
    /// Financial institution ID.
     let financialInstitutionId: Int64?
    /// Last synchronization datetime.
     let lastSyncDate: Date?
    /// The last day of the forthcoming billing cycle.
     let nextClosingDate: Date?
    /// The reservation of a portion of a credit or debit balance for the cost of services not yet rendered.
     let reservedAmount: Double?
    /// The limitation in periodic saving transfers or withdrawals. In the case of the US,
    /// Regulation D enables for a maximum of 6 monthly savings transfers or withdrawals.
     let remainingPeriodicTransfers: Double?
    /// The date in which the arrangement has been overdue since.
     let overdueSince: Date?
    /// Synchronization statuses an account can have on the provider side after it has been aggregated.
     let externalAccountStatus: String?
    /// Card details
     let cardDetails: CardDetails?
    /// Interest Details
     let interestDetails: InterestDetails?
    
    /// Create a new `GeneralAccount` object.
    /// - Parameters:
    ///   - bookedBalance: Optional bookedBalance. Defaults to `nil`
    ///   - availableBalance: Optional availableBalance. Defaults to `nil`
    ///   - creditLimit: Optional creditLimit. Defaults to `nil`
    ///   - iban: Optional iban. Defaults to `nil`
    ///   - bban: Optional bban. Defaults to `nil`
    ///   - currency: Optional currency. Defaults to `nil`
    ///   - urgentTransferAllowed: Optional urgentTransferAllowed. Defaults to `nil`
    ///   - bic: Optional bic. Defaults to `nil`
    ///   - bankBranchCode: Optional bankBranchCode. Defaults to `nil`
    ///   - bankBranchCode2: Optional bankBranchCode2. Defaults to `nil`
    ///   - accountInterestRate: Optional accountInterestRate. Defaults to `nil`
    ///   - valueDateBalance: Optional valueDateBalance. Defaults to `nil`
    ///   - creditLimitUsage: Optional creditLimitUsage. Defaults to `nil`
    ///   - creditLimitInterestRate: Optional creditLimitInterestRate. Defaults to `nil`
    ///   - creditLimitExpiryDate: Optional creditLimitExpiryDate. Defaults to `nil`
    ///   - accruedInterest: Optional accruedInterest. Defaults to `nil`
    ///   - debitCardsItems: Optional debitCardsItems. Defaults to `nil`
    ///   - startDate: Optional startDate. Defaults to `nil`
    ///   - minimumRequiredBalance: Optional minimumRequiredBalance. Defaults to `nil`
    ///   - accountHolderAddressLine1: Optional accountHolderAddressLine1. Defaults to `nil`
    ///   - accountHolderAddressLine2: Optional accountHolderAddressLine2. Defaults to `nil`
    ///   - accountHolderStreetName: Optional accountHolderStreetName. Defaults to `nil`
    ///   - town: Optional town. Defaults to `nil`
    ///   - postCode: Optional postCode. Defaults to `nil`
    ///   - countrySubDivision: Optional countrySubDivision. Defaults to `nil`
    ///   - accountHolderNames: Optional accountHolderNames. Defaults to `nil`
    ///   - accountHolderCountry: Optional accountHolderCountry. Defaults to `nil`
    ///   - number: Optional number. Defaults to `nil`
    ///   - cardNumber: Optional cardNumber. Defaults to `nil`
    ///   - creditCardAccountNumber: Optional creditCardAccountNumber. Defaults to `nil`
    ///   - validThru: Optional validThru. Defaults to `nil`
    ///   - applicableInterestRate: Optional applicableInterestRate. Defaults to `nil`
    ///   - remainingCredit: Optional remainingCredit. Defaults to `nil`
    ///   - outstandingPayment: Optional outstandingPayment. Defaults to `nil`
    ///   - minimumPayment: Optional minimumPayment. Defaults to `nil`
    ///   - minimumPaymentDueDate: Optional minimumPaymentDueDate. Defaults to `nil`
    ///   - currentInvestmentValue: Optional currentInvestmentValue. Defaults to `nil`
    ///   - productNumber: Optional productNumber. Defaults to `nil`
    ///   - principalAmount: Optional principalAmount. Defaults to `nil`
    ///   - termUnit: Optional termUnit. Defaults to `nil`
    ///   - termNumber: Optional termNumber. Defaults to `nil`
    ///   - outstandingPrincipalAmount: Optional outstandingPrincipalAmount. Defaults to `nil`
    ///   - monthlyInstalmentAmount: Optional monthlyInstalmentAmount. Defaults to `nil`
    ///   - amountInArrear: Optional amountInArrear. Defaults to `nil`
    ///   - interestSettlementAccount: Optional interestSettlementAccount. Defaults to `nil`
    ///   - maturityDate: Optional maturityDate. Defaults to `nil`
    ///   - maturityAmount: Optional maturityAmount. Defaults to `nil`
    ///   - autoRenewalIndicator: Optional autoRenewalIndicator. Defaults to `nil`
    ///   - interestPaymentFrequencyUnit: Optional interestPaymentFrequencyUnit. Defaults to `nil`
    ///   - interestPaymentFrequencyNumber: Optional interestPaymentFrequencyNumber. Defaults to `nil`
    ///   - creditAccount: Optional creditAccount. Defaults to `nil`
    ///   - debitAccount: Optional debitAccount. Defaults to `nil`
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
    ///   - nextClosingDate: The last day of the forthcoming billing cycle.
    ///   - reservedAmount: The reservation of a portion of a credit or debit balance for the cost of services not yet rendered.
    ///   - remainingPeriodicTransfers: The limitation in periodic saving transfers or withdrawals. In the case of the US,
    ///   Regulation D enables for a maximum of 6 monthly savings transfers or withdrawals.
    ///   - overdueSince: The date in which the arrangement has been overdue since.
    ///   - externalAccountStatus: Synchronization statuses an account can have on the provider side after it has been aggregated.
    ///   - cardDetails: Card details
    ///   - interestDetails: Interest Details
     init(
        bookedBalance: String? = nil,
        availableBalance: String? = nil,
        creditLimit: String? = nil,
        iban: String? = nil,
        bban: String? = nil,
        currency: String? = nil,
        urgentTransferAllowed: Bool? = nil,
        bic: String? = nil,
        bankBranchCode: String? = nil,
        bankBranchCode2: String? = nil,
        accountInterestRate: Double? = nil,
        valueDateBalance: Double? = nil,
        creditLimitUsage: Double? = nil,
        creditLimitInterestRate: Double? = nil,
        creditLimitExpiryDate: Date? = nil,
        accruedInterest: Double? = nil,
        debitCardsItems: [DebitCardItem],
        startDate: Date? = nil,
        minimumRequiredBalance: Double? = nil,
        accountHolderAddressLine1: String? = nil,
        accountHolderAddressLine2: String? = nil,
        accountHolderStreetName: String? = nil,
        town: String? = nil,
        postCode: String? = nil,
        countrySubDivision: String? = nil,
        accountHolderNames: String? = nil,
        accountHolderCountry: String? = nil,
        number: String? = nil,
        cardNumber: Double? = nil,
        creditCardAccountNumber: String? = nil,
        validThru: Date? = nil,
        applicableInterestRate: Double? = nil,
        remainingCredit: Double? = nil,
        outstandingPayment: Double? = nil,
        minimumPayment: Double? = nil,
        minimumPaymentDueDate: Date? = nil,
        currentInvestmentValue: String? = nil,
        productNumber: String? = nil,
        principalAmount: Double? = nil,
        termUnit: TimeUnit? = nil,
        termNumber: Double? = nil,
        outstandingPrincipalAmount: Double? = nil,
        monthlyInstalmentAmount: Double? = nil,
        amountInArrear: Double? = nil,
        interestSettlementAccount: String? = nil,
        maturityDate: Date? = nil,
        maturityAmount: Double? = nil,
        autoRenewalIndicator: Bool? = nil,
        interestPaymentFrequencyUnit: TimeUnit? = nil,
        interestPaymentFrequencyNumber: Double? = nil,
        creditAccount: Bool? = nil,
        debitAccount: Bool? = nil,
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
        nextClosingDate: Date? = nil,
        reservedAmount: Double? = nil,
        remainingPeriodicTransfers: Double? = nil,
        overdueSince: Date? = nil,
        externalAccountStatus: String? = nil,
        cardDetails: CardDetails? = nil,
        interestDetails: InterestDetails? = nil
    ) {
        self.bookedBalance = bookedBalance
        self.availableBalance = availableBalance
        self.creditLimit = creditLimit
        self.iban = iban
        self.bban = bban
        self.currency = currency
        self.urgentTransferAllowed = urgentTransferAllowed
        self.bic = bic
        self.bankBranchCode = bankBranchCode
        self.bankBranchCode2 = bankBranchCode2
        self.accountInterestRate = accountInterestRate
        self.valueDateBalance = valueDateBalance
        self.creditLimitUsage = creditLimitUsage
        self.creditLimitInterestRate = creditLimitInterestRate
        self.creditLimitExpiryDate = creditLimitExpiryDate
        self.accruedInterest = accruedInterest
        self.debitCardsItems = debitCardsItems
        self.startDate = startDate
        self.minimumRequiredBalance = minimumRequiredBalance
        self.accountHolderAddressLine1 = accountHolderAddressLine1
        self.accountHolderAddressLine2 = accountHolderAddressLine2
        self.accountHolderStreetName = accountHolderStreetName
        self.town = town
        self.postCode = postCode
        self.countrySubDivision = countrySubDivision
        self.accountHolderNames = accountHolderNames
        self.accountHolderCountry = accountHolderCountry
        self.number = number
        self.cardNumber = cardNumber
        self.creditCardAccountNumber = creditCardAccountNumber
        self.validThru = validThru
        self.applicableInterestRate = applicableInterestRate
        self.remainingCredit = remainingCredit
        self.outstandingPayment = outstandingPayment
        self.minimumPayment = minimumPayment
        self.minimumPaymentDueDate = minimumPaymentDueDate
        self.currentInvestmentValue = currentInvestmentValue
        self.productNumber = productNumber
        self.principalAmount = principalAmount
        self.termUnit = termUnit
        self.termNumber = termNumber
        self.outstandingPrincipalAmount = outstandingPrincipalAmount
        self.monthlyInstalmentAmount = monthlyInstalmentAmount
        self.amountInArrear = amountInArrear
        self.interestSettlementAccount = interestSettlementAccount
        self.maturityDate = maturityDate
        self.maturityAmount = maturityAmount
        self.autoRenewalIndicator = autoRenewalIndicator
        self.interestPaymentFrequencyUnit = interestPaymentFrequencyUnit
        self.interestPaymentFrequencyNumber = interestPaymentFrequencyNumber
        self.creditAccount = creditAccount
        self.debitAccount = debitAccount
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
        self.nextClosingDate = nextClosingDate
        self.reservedAmount = reservedAmount
        self.remainingPeriodicTransfers = remainingPeriodicTransfers
        self.overdueSince = overdueSince
        self.externalAccountStatus = externalAccountStatus
        self.cardDetails = cardDetails
        self.interestDetails = interestDetails
    }
}
