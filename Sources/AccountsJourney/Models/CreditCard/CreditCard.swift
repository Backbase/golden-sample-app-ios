//
//  CreditCard.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 11/10/2023.
//

import Foundation


/// Credit card account type.
public struct CreditCard: Equatable {
    /// Booked balance
    public let bookedBalance: String?
    /// Available balance
    public let availableBalance: String?
    /// Credit limit for the account
    public let creditLimit: String?
    /// First 6 and/or last 4 digits of a Payment card. All other digits will/to be masked.
    /// Be aware that using card number differently is potential PCI risk.
    public let number: String?
    /// Currency code that is applicable for the account.
    public let currency: String?
    /// Defines if urgent transfer is allowed.
    public let urgentTransferAllowed: Bool?
    /// Credit card number
    public let cardNumber: Double?
    /// The number of the account the credit card transactions settle on
    /// (so actually the reference to the settlement account of the card)
    public let creditCardAccountNumber: String?
    /// Another country-specific bank identification number or code:
    /// the Fedwire Routing Number in the US or another country-specific identifier.
    public let bankBranchCode2: String?
    /// Expiration date of a credit card, after which is no longer valid.
    public let validThru: Date?
    /// The interest rate or rates which would be used for a particular arrangement.
    public let applicableInterestRate: Double?
    /// Remaining credit from the card limit.
    public let remainingCredit: Double?
    /// Outstanding payment to be paid to the bank.
    public let outstandingPayment: Double?
    /// The minimum payment set a percentage of balance, or a fixed cash amount.
    public let minimumPayment: Double?
    /// Minimum Payment Due Date shown on your monthly statement to remain in good standing.
    public let minimumPaymentDueDate: Date?
    /// The annualized cost of credit or debt-capital computed as the percentage ratio of interest to the principal.
    public let accountInterestRate: Double?
    /// Party(s) with a relationship to the account.
    public let accountHolderNames: String?
    /// Monetary amount of the used overdraft.
    public let creditLimitUsage: Double?
    /// Overdraft Interest is an interest applied to the account for any time
    /// throughout the month when the account is overdrawn.
    public let creditLimitInterestRate: Double?
    /// Accrued interest
    public let accruedInterest: Double?
    /// Additional fields
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
    /// Account opening date.
    public let accountOpeningDate: Date?
    /// Last date of parameter update for the arrangement.
    public let lastUpdateDate: Date?
    /// User preferences.
    public let userPreferences: UserPreferences?
    /// State of the account.
    public let state: ProductState?
    /// Reference to the parent of the arrangement.
    public let parentId: String?
    /// Sub-arrangements
    public let subArrangements: [BaseProduct]?
    /// Financial institution ID.
    public let financialInstitutionId: Int64?
    /// Last synchronization datetime.
    public let lastSyncDate: Date?
    /// Card details.
    public let cardDetails: CardDetails?
    /// Interest details.
    public let interestDetails: InterestDetails?
    /// The reservation of a portion of a credit or debit balance for the cost of services not yet rendered.
    public let reservedAmount: Double?
    /// The limitation in periodic saving transfers or withdrawals. In the case of the US,
    /// Regulation D enables for a maximum of 6 monthly savings transfers or withdrawals.
    public let remainingPeriodicTransfers: Double?
    /// The last day of the forthcoming billing cycle.
    public let nextClosingDate: Date?
    /// The date in which the arrangement has been overdue since.
    public let overdueSince: Date?
    /// Synchronization statuses an account can have on the provider side after it has been aggregated.
    public let externalAccountStatus: String?
    
    /// Create a new `CreditCard` object.
    /// - Parameters:
    ///   - bookedBalance: Optional booked balance. Defaults to `nil`
    ///   - availableBalance: Optional available balance. Defaults to `nil`
    ///   - creditLimit: Optional creditLimit. Defaults to `nil`
    ///   - number: Optional number. Defaults to `nil`
    ///   - currency: Optional currency. Defaults to `nil`
    ///   - urgentTransferAllowed: Optional urgentTransferAllowed. Defaults to `nil`
    ///   - cardNumber: Optional cardNumber. Defaults to `nil`
    ///   - creditCardAccountNumber: Optional creditCardAccountNumber. Defaults to `nil`
    ///   - bankBranchCode2: Optional bankBranchCode2. Defaults to `nil`
    ///   - validThru: Optional validThru. Defaults to `nil`
    ///   - applicableInterestRate: Optional applicableInterestRate. Defaults to `nil`
    ///   - remainingCredit: Optional remainingCredit. Defaults to `nil`
    ///   - outstandingPayment: Optional outstandingPayment. Defaults to `nil`
    ///   - minimumPayment: Optional minimumPayment. Defaults to `nil`
    ///   - minimumPaymentDueDate: Optional minimumPaymentDueDate. Defaults to `nil`
    ///   - accountInterestRate: Optional accountInterestRate. Defaults to `nil`
    ///   - accountHolderNames: Optional accountHolderNames. Defaults to `nil`
    ///   - creditLimitUsage: Optional creditLimitUsage. Defaults to `nil`
    ///   - creditLimitInterestRate: Optional creditLimitInterestRate. Defaults to `nil`
    ///   - accruedInterest: Optional accruedInterest. Defaults to `nil`
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
    ///   - cardDetails: Card details. Defaults to `nil`
    ///   - interestDetails: Interest details. Defaults to `nil`
    ///   - reservedAmount: The reservation of a portion of a credit or debit balance for the cost of services not yet rendered.
    ///   Defaults to `nil`
    ///   - remainingPeriodicTransfers: The limitation in periodic saving transfers or withdrawals.
    ///   In the case of the US, Regulation D enables for a maximum of 6 monthly savings transfers or withdrawals. Defaults to `nil`
    ///   - nextClosingDate: The last day of the forthcoming billing cycle. Defaults to `nil`
    ///   - overdueSince: The date in which the arrangement has been overdue since. Defaults to `nil`
    ///   - externalAccountStatus: Synchronization statuses an account can have on the provider side after it has been aggregated. Defaults to `nil`
    public init(bookedBalance: String? = nil,
         availableBalance: String? = nil,
         creditLimit: String? = nil,
         number: String? = nil,
         currency: String? = nil,
         urgentTransferAllowed: Bool? = nil,
         cardNumber: Double? = nil,
         creditCardAccountNumber: String? = nil,
         bankBranchCode2: String? = nil,
         validThru: Date? = nil,
         applicableInterestRate: Double? = nil,
         remainingCredit: Double? = nil,
         outstandingPayment: Double? = nil,
         minimumPayment: Double? = nil,
         minimumPaymentDueDate: Date? = nil,
         accountInterestRate: Double? = nil,
         accountHolderNames: String? = nil,
         creditLimitUsage: Double? = nil,
         creditLimitInterestRate: Double? = nil,
         accruedInterest: Double? = nil,
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
         cardDetails: CardDetails? = nil,
         interestDetails: InterestDetails? = nil,
         reservedAmount: Double? = nil,
         remainingPeriodicTransfers: Double? = nil,
         nextClosingDate: Date? = nil,
         overdueSince: Date? = nil,
         externalAccountStatus: String? = nil
    ) {
        // this one is the most newer init
        self.bookedBalance = bookedBalance
        self.availableBalance = availableBalance
        self.creditLimit = creditLimit
        self.number = number
        self.currency = currency
        self.urgentTransferAllowed = urgentTransferAllowed
        self.cardNumber = cardNumber
        self.creditCardAccountNumber = creditCardAccountNumber
        self.bankBranchCode2 = bankBranchCode2
        self.validThru = validThru
        self.applicableInterestRate = applicableInterestRate
        self.remainingCredit = remainingCredit
        self.outstandingPayment = outstandingPayment
        self.minimumPayment = minimumPayment
        self.minimumPaymentDueDate = minimumPaymentDueDate
        self.accountInterestRate = accountInterestRate
        self.accountHolderNames = accountHolderNames
        self.creditLimitUsage = creditLimitUsage
        self.creditLimitInterestRate = creditLimitInterestRate
        self.accruedInterest = accruedInterest
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
        self.cardDetails = cardDetails
        self.interestDetails = interestDetails
        self.reservedAmount = reservedAmount
        self.remainingPeriodicTransfers = remainingPeriodicTransfers
        self.nextClosingDate = nextClosingDate
        self.overdueSince = overdueSince
        self.externalAccountStatus = externalAccountStatus
    }
}
