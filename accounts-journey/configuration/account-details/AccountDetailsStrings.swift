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
