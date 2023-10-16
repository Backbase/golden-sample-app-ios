//
//  CurrentAccount.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 11/10/2023.
//

import Foundation

/// Current account type.
public struct CurrentAccount: Equatable {
    /// Total balance of the account
    public let bookedBalance: String?
    /// Available balance to be used.
    public let availableBalance: String?
    /// Credit limit of the credit cards
    public let creditLimit: String?
    /// Specifying the IBAN - IBAN is short for International Bank Account Number of the account.
    public let iban: String?
    /// Specifying the BBAN of the account - BBAN is short for Basic Bank Account Number.
    /// It represents a country-specific bank account number.
    public let bban: String?
    /// The alpha-3 code (complying with ISO 4217) of the currency that qualifies the amount.
    public let currency: String?
    /// Defines if urgent transfer is allowed.
    public let urgentTransferAllowed: Bool?
    /// Bank Identifier Code - international bank code that identifies particular banks worldwide
    public let bic: String?
    /// This is to accommodate additional country specific fields like Sort Code in UK.
    public let bankBranchCode: String?
    /// Another country-specific bank identification number or code:
    /// the Fedwire Routing Number in the US or another country-specific identifier.
    public let bankBranchCode2: String?
    /// The annualized cost of credit or debt-capital computed as the percentage ratio of interest to the principal.
    public let accountInterestRate: Double?
    /// The balance of the account on a specific date that needs to be used for the calculation of interest.
    /// If no date is specified (like for the book date balance) the current date can be assumed.
    public let valueDateBalance: Double?
    /// Monetary amount of the used overdraft.
    public let creditLimitUsage: Double?
    /// Overdraft Interest is an interest applied to the account for any time throughout the month when the account is overdrawn.
    public let creditLimitInterestRate: Double?
    /// The date after which overdraft will no longer be available to the account (renewed automatically or cancelled).
    public let creditLimitExpiryDate: Date?
    /// Accrued interest
    public let accruedInterest: Double?
    /// Debit card items linked to this account.
    public let debitCardsItems: [DebitCardItem]
    /// Party(s) with a relationship to the account.
    public let accountHolderNames: String?
    /// Start date
    public let startDate: Date?
    /// Minimum amount that a customer must have in an account in order to receive some sort of service,
    /// such as keeping the account open or receive interest.
    public let minimumRequiredBalance: Double?
    /// Address of the Payer/Payee - Alternate address line for the account.
    public let accountHolderAddressLine1: String?
    /// Address of the Payer/Payee - Alternate address line for the account.
    public let accountHolderAddressLine2: String?
    /// Street name of the Payer/Payee - Alternate street name for the account.
    public let accountHolderStreetName: String?
    /// Town of the Payer/Payee - Alternate town for the account.
    public let town: String?
    /// Post of the Payer/Payee.
    public let postCode: String?
    /// Country subdivision of the Payer/Payee.
    public let countrySubDivision: String?
    /// Indicator whether or not the arrangement can be used in payment orders as credit account.
    public let creditAccount: Bool?
    /// Indicator whether or not the arrangement can be used in payment orders as debit account.
    public let debitAccount: Bool?
    /// Country of the account holder.
    public let accountHolderCountry: String?
    /// Additional fields.
    public let additions: [String: String]?
    /// Reference to the product of which the arrangement is an instantiation.
    public let identifier: String?
    /// An optional list of the maskable attributes that can be unmasked.
    public let unmaskableAttributes: [MaskableAttribute]?
    /// Name of the account
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
    /// User preferences for the account
    public let userPreferences: UserPreferences?
    /// State of the account.
    public let state: ProductState?
    /// Reference to the parent of the arrangement.
    public let parentId: String?
    /// Sub-arrangements for this account.
    public let subArrangements: [BaseProduct]?
    /// Financial institution ID.
    public let financialInstitutionId: Int64?
    /// Last synchronization datetime.
    public let lastSyncDate: Date?
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
    
    /// Create a new `CurrentAccount` object.
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
    ///   - accountHolderNames: Optional accountHolderNames. Defaults to `nil`
    ///   - startDate: Optional startDate. Defaults to `nil`
    ///   - minimumRequiredBalance: Optional minimumRequiredBalance. Defaults to `nil`
    ///   - accountHolderAddressLine1: Optional accountHolderAddressLine1. Defaults to `nil`
    ///   - accountHolderAddressLine2: Optional accountHolderAddressLine2. Defaults to `nil`
    ///   - accountHolderStreetName: Optional accountHolderStreetName. Defaults to `nil`
    ///   - town: Optional town. Defaults to `nil`
    ///   - postCode: Optional postCode. Defaults to `nil`
    ///   - countrySubDivision: Optional countrySubDivision. Defaults to `nil`
    ///   - creditAccount: Optional creditAccount. Defaults to `nil`
    ///   - debitAccount: Optional debitAccount. Defaults to `nil`
    ///   - accountHolderCountry: Optional accountHolderCountry. Defaults to `nil`
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
    public init(
        // swiftlint:disable:previous function_body_length
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
        accountHolderNames: String? = nil,
        startDate: Date? = nil,
        minimumRequiredBalance: Double? = nil,
        accountHolderAddressLine1: String? = nil,
        accountHolderAddressLine2: String? = nil,
        accountHolderStreetName: String? = nil,
        town: String? = nil,
        postCode: String? = nil,
        countrySubDivision: String? = nil,
        creditAccount: Bool? = nil,
        debitAccount: Bool? = nil,
        accountHolderCountry: String? = nil,
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
        self.accountHolderNames = accountHolderNames
        self.startDate = startDate
        self.minimumRequiredBalance = minimumRequiredBalance
        self.accountHolderAddressLine1 = accountHolderAddressLine1
        self.accountHolderAddressLine2 = accountHolderAddressLine2
        self.accountHolderStreetName = accountHolderStreetName
        self.town = town
        self.postCode = postCode
        self.countrySubDivision = countrySubDivision
        self.creditAccount = creditAccount
        self.debitAccount = debitAccount
        self.accountHolderCountry = accountHolderCountry
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
