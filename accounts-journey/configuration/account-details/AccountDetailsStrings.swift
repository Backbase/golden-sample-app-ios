//
//  AccountDetailsStrings.swift
//  AccountsJourney
//
//  Created by George Nyakundi on 29/11/2023.
//

import Foundation

extension AccountDetails {
    public struct Strings {
        public init() {
            // no code required
        }
        
        /// accountsJourney.accountDetails.labels.title
        public var screenTitle = localized(key: "labels.title")
        
        /// accountsJourney.accountDetails.labels.section.general
        public var generalSectionTitle = localized(key: "labels.section.general")
        /// accountsJourney.accountDetails.labels.section.status
        public var statusSectionTitle = localized(key: "labels.section.status")
        /// accountsJourney.accountDetails.labels.common.accountName
        public var accountNameTitle = localized(key: "labels.common.accountName")
        /// accountsJourney.accountDetails.labels.common.accountStatus
        public var accountStatusTitle = localized(key: "labels.common.accountStatus")
        /// accountsJourney.accountDetails.labels.common.accountType
        public var accountTypeTitle = localized(key: "labels.common.accountType")
        /// accountsJourney.accountDetails.labels.common.cardOrAccountNumber
        public var cardOrAccountNumberTitle = localized(key: "labels.common.cardOrAccountNumber")
        /// accountsJourney.accountDetails.labels.common.holderNames
        public var holderNamesTitle = localized(key: "labels.common.holderNames")
        /// accountsJourney.accountDetails.labels.common.limit
        public var limitTitle = localized(key: "labels.common.limit")
        /// accountsJourney.accountDetails.errors.{error}.title
        public var errorTitle: ErrorFormatter<LocalizedString> = { error in
            switch error {
            case .notConnected:
                localized(key: "errors.notConnected.title")
            default:
                localized(key: "errors.generic.title")
            }
        }
        
        /// accountsJourney.accountDetails.errors.{error}.subtitle
        public var errorSubtitle: ErrorFormatter<LocalizedString> = { error in
            switch error {
            case .notConnected:
                localized(key: "errors.notConnected.subtitle")
            default:
                localized(key: "errors.generic.subtitle")
            }
        }
        /// accountsJourney.accountsList.errors.{error}.actionButton
        public var errorRetryButtonTitle: ErrorFormatter<LocalizedString?> = { error in
            switch error {
            case .notConnected:
                localized(key: "errors.notConnected.actionButton")
            default:
                localized(key: "errors.generic.actionButton")
            }
        }
        
        // MARK: - Private
        private static func localized(key: String) -> LocalizedString {
            let prefix = "accountsJourney.accountDetails."
            return LocalizedString(key: prefix + key, in: .accountsJourney)
        }
    }
}
