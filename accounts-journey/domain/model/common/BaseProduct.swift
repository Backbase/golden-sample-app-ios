//
//  BaseProduct.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 11/10/2023.
//

import Foundation

extension AccountsJourney {
    /// Base product for sub-arrangements
    public struct BaseProduct: Codable, Equatable {
        /// Reference to the product of which the arrangement is an instantiation.
        public let identifier: String?
        /// Name of the account
        public let name: String?
        /// Represents an arrangement by it's correct naming identifier. It could be account alias or user alias depending on the journey
        /// selected by the financial institution. If none of those is set, the arrangement name will be used.
        public let displayName: String?
        /// Defines if transfer to another party is allowed.
        public let externalTransferAllowed: Bool?
        /// Defines if cross currency transfer is allowed
        public let crossCurrencyAllowed: Bool?
        /// The label/name that is used for the respective product kind
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
        /// Extra preferences
        public let userPreferences: AccountsJourney.UserPreferences?
        /// State of the account
        public let state: ProductState?
        /// Reference to the parent of the arrangement if this product is a sub-arrangement
        public let parentId: String?
        /// Subarrangements
        public let subArrangements: [BaseProduct]?
        /// Financial institution ID
        public let financialInstitutionId: Int64?
        /// Last synchronization datetime
        public let lastSyncDate: Date?
        /// Additional fields
        public let additions: [String: String]?
        /// Card Details
        public let cardDetails: CardDetails?
        /// Another country-specific bank identification number or code:
        /// the Fedwire Routing Number in the US or another country-specific identifier.
        public let bankBranchCode2: String?
        /// The last day of the forthcoming billing cycle.
        public let nextClosingDate: Date?
        /// Interest Details
        public let interestDetails: InterestDetails?
        /// Synchronization statuses an account can have on the provider side after it has been aggregated.
        public let externalAccountStatus: String?
        /// The limitation in periodic saving transfers or withdrawals.
        /// In the case of the US, Regulation D enables for a maximum of 6 monthly savings transfers or withdrawals.
        public let remainingPeriodicTransfers: Double?
        /// The reservation of a portion of a credit or debit balance for the cost of services not yet rendered.
        public let reservedAmount: Double?
        /// The date in which the arrangement has been overdue since.
        public let overdueSince: Date?
        
        /// Create a new `BaseProduct` object.
        /// - Parameters:
        ///   - identifier: Optional identifier. Defaults to `nil`
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
        ///   - additions: Optional additions. Defaults to `nil`
        ///   - cardDetails: Card Details
        ///   - bankBranchCode2: Another country-specific bank identification number or code:
        ///   the Fedwire Routing Number in the US or another country-specific identifier.
        ///   - nextClosingDate: The last day of the forthcoming billing cycle.
        ///   - interestDetails: Interest Details
        ///   - externalAccountStatus: Synchronization statuses an account can have on the provider side after it has been aggregated.
        ///   - remainingPeriodicTransfers: The limitation in periodic saving transfers or withdrawals.
        ///   In the case of the US, Regulation D enables for a maximum of 6 monthly savings transfers or withdrawals.
        ///   - reservedAmount: The reservation of a portion of a credit or debit balance for the cost of services not yet rendered.
        ///   - overdueSince: The date in which the arrangement has been overdue since.
        public init(identifier: String? = nil,
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
                    userPreferences: AccountsJourney.UserPreferences? = nil,
                    state: ProductState? = nil,
                    parentId: String? = nil,
                    subArrangements: [BaseProduct]? = nil,
                    financialInstitutionId: Int64? = nil,
                    lastSyncDate: Date? = nil,
                    additions: [String: String]? = nil,
                    cardDetails: CardDetails? = nil,
                    bankBranchCode2: String? = nil,
                    nextClosingDate: Date? = nil,
                    interestDetails: InterestDetails? = nil,
                    externalAccountStatus: String? = nil,
                    remainingPeriodicTransfers: Double? = nil,
                    reservedAmount: Double? = nil,
                    overdueSince: Date? = nil
        ) {
            self.identifier = identifier
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
            self.additions = additions
            self.cardDetails = cardDetails
            self.bankBranchCode2 = bankBranchCode2
            self.nextClosingDate = nextClosingDate
            self.interestDetails = interestDetails
            self.externalAccountStatus = externalAccountStatus
            self.remainingPeriodicTransfers = remainingPeriodicTransfers
            self.reservedAmount = reservedAmount
            self.overdueSince = overdueSince
        }
    }
}
