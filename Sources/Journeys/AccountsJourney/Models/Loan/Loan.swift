//
//  Loan.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 11/10/2023.
//

import Foundation

/// Loan account type.
 struct Loan: Equatable {
    
    internal enum LoanState: String {
        case active = "Active"
        case inactive = "Inactive"
        case closed = "Closed"
        case unknownState = "" // Not an actual case returned by server, but useful to check if there is no state at all
    }
    
    internal enum LoanType: String {
        case mortgage = "Mortgage"
        case termLoan = "TermLoan"
        case lineOfCredit = "LineOfCredit"
        case commitment = "Commitment"
    }
    
    /// Booked balance
     let bookedBalance: String?
    /// Principal amount
     let principalAmount: Double?
    /// Currency
     let currency: String?
    /// Defines if urgent transfer is allowed.
     let urgentTransferAllowed: Bool?
    /// The number identifying the contract.
     let productNumber: String?
    /// The annualized cost of credit or debt-capital computed as the percentage ratio of interest to the principal.
     let accountInterestRate: Double?
    /// Term unit
     let termUnit: TimeUnit?
    /// The number of times interest rate is paid on the settlement account.
     let termNumber: Double?
    /// This is the value date balance of the arrangement.
     let outstandingPrincipalAmount: Double?
    /// A fixed payment amount paid by a borrower to the bank at a specified date each calendar month.
     let monthlyInstalmentAmount: Double?
    /// The part of a debt that is overdue after missing one or more required payments.
    /// The amount of the arrears is the amount accrued from the date on which the first missed payment was due.
     let amountInArrear: Double?
    /// Account that provides quick access to accumulated cash to facilitate daily settlements with other businesses.
     let interestSettlementAccount: String?
    /// Accrued interest
     let accruedInterest: Double?
    /// Party(s) with a relationship to the account.
     let accountHolderNames: String?
    /// End term of a holding period.
     let maturityDate: Date?
    /// The balance of the account on a specific date that needs to be used for the calculation of interest.
    /// If no date is specified (like for the book date balance) the current date can be assumed.
     let valueDateBalance: Double?
    /// Indicator whether or not the arrangement can be used in payment orders as credit account.
     let creditAccount: Bool?
    /// Indicator whether or not the arrangement can be used in payment orders as debit account.
     let debitAccount: Bool?
    /// Specifying the IBAN - IBAN is short for International Bank Account Number of the account.
     let iban: String?
    /// Specifying the BBAN of the account - BBAN is short for Basic Bank Account Number.
    /// It represents a country-specific bank account number.
     let bban: String?
    /// Additions
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
    /// User preferences
     let userPreferences: UserPreferences?
    /// State of the account
     let state: ProductState?
    /// Reference to the parent of the arrangement.
     let parentId: String?
    /// Sub-arrangements of the account
     let subArrangements: [BaseProduct]?
    /// Financial institution ID.
     let financialInstitutionId: Int64?
    /// Last synchronization datetime.
     let lastSyncDate: Date?
    /// Another country-specific bank identification number or code:
    /// the Fedwire Routing Number in the US or another country-specific identifier.
     let bankBranchCode2: String?
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
    /// This property is to accommodate additional country specific fields like Sort Code in UK.
     let bankBranchCode: String?
    /// Credit limit for the account
     let creditLimit: String?
    /// Available balance
     let availableBalance: String?
    /// The minimum payment set a percentage of balance, or a fixed cash amount.
     let minimumPayment: Double?
    /// Minimum Payment Due Date shown on your monthly statement to remain in good standing.
     let minimumPaymentDueDate: Date?
    
    /// Create a new `Loan` object.
    /// - Parameters:
    ///   - bookedBalance: Optional bookedBalance. Defaults to `nil`
    ///   - principalAmount: Optional principalAmount. Defaults to `nil`
    ///   - currency: Optional currency. Defaults to `nil`
    ///   - urgentTransferAllowed: Optional urgentTransferAllowed. Defaults to `nil`
    ///   - productNumber: Optional productNumber. Defaults to `nil`
    ///   - accountInterestRate: Optional accountInterestRate. Defaults to `nil`
    ///   - termUnit: Optional termUnit. Defaults to `nil`
    ///   - termNumber: Optional termNumber. Defaults to `nil`
    ///   - outstandingPrincipalAmount: Optional outstandingPrincipalAmount. Defaults to `nil`
    ///   - monthlyInstalmentAmount: Optional monthlyInstalmentAmount. Defaults to `nil`
    ///   - amountInArrear: Optional amountInArrear. Defaults to `nil`
    ///   - interestSettlementAccount: Optional interestSettlementAccount. Defaults to `nil`
    ///   - accruedInterest: Optional accruedInterest. Defaults to `nil`
    ///   - accountHolderNames: Optional accountHolderNames. Defaults to `nil`
    ///   - maturityDate: Optional maturityDate. Defaults to `nil`
    ///   - valueDateBalance: Optional valueDateBalance. Defaults to `nil`
    ///   - creditAccount: Optional creditAccount. Defaults to `nil`
    ///   - debitAccount: Optional debitAccount. Defaults to `nil`
    ///   - iban: Optional iban. Defaults to `nil`
    ///   - bban: Optional bban. Defaults to `nil`
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
     init(
        bookedBalance: String? = nil,
        principalAmount: Double? = nil,
        currency: String? = nil,
        urgentTransferAllowed: Bool? = nil,
        productNumber: String? = nil,
        accountInterestRate: Double? = nil,
        termUnit: TimeUnit? = nil,
        termNumber: Double? = nil,
        outstandingPrincipalAmount: Double? = nil,
        monthlyInstalmentAmount: Double? = nil,
        amountInArrear: Double? = nil,
        interestSettlementAccount: String? = nil,
        accruedInterest: Double? = nil,
        accountHolderNames: String? = nil,
        maturityDate: Date? = nil,
        valueDateBalance: Double? = nil,
        creditAccount: Bool? = nil,
        debitAccount: Bool? = nil,
        iban: String? = nil,
        bban: String? = nil,
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
        self.currency = currency
        self.urgentTransferAllowed = urgentTransferAllowed
        self.productNumber = productNumber
        self.accountInterestRate = accountInterestRate
        self.termUnit = termUnit
        self.termNumber = termNumber
        self.outstandingPrincipalAmount = outstandingPrincipalAmount
        self.monthlyInstalmentAmount = monthlyInstalmentAmount
        self.amountInArrear = amountInArrear
        self.interestSettlementAccount = interestSettlementAccount
        self.accruedInterest = accruedInterest
        self.accountHolderNames = accountHolderNames
        self.maturityDate = maturityDate
        self.valueDateBalance = valueDateBalance
        self.creditAccount = creditAccount
        self.debitAccount = debitAccount
        self.iban = iban
        self.bban = bban
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
    
    internal func isLoan(_ loanState: LoanState) -> Bool {
        
        if case .unknownState = loanState, state?.state == nil {
            return true
        }
        
        return state?.state?.lowercased() == loanState.rawValue.lowercased()
    }
}
