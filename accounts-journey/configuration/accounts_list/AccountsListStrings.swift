//
//  AccountsListStrings.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 27/11/2023.
//

import Foundation

extension AccountsList {
    public struct Strings {
        /// Create a new strings object with default values
        public init() {
            // no code required
        }
        /// accountsJourney.accountsList.labels.title
        public var screenTitle = localized(key: "labels.title")
        /// accountsJourney.accountsList.labels.searchText
        public var searchText = localized(key: "labels.searchText")
        /// accountsJourney.accountsList.labels.section.title.creditCards
        public var creditCardTitle = localized(key: "labels.section.title.creditCards")
        /// accountsJourney.accountsList.labels.section.title.currentAccounts
        public var currentAccountTitle = localized(key: "labels.section.title.currentAccounts")
        /// accountsJourney.accountsList.labels.section.title.debitCards
        public var debitCardTitle = localized(key: "labels.section.title.debitCards")
        /// accountsJourney.accountsList.labels.section.title.investmentAccounts
        public var investmentAccountTitle = localized(key: "labels.section.title.investmentAccounts")
        /// accountsJourney.accountsList.labels.section.title.loans
        public var loanAccountTitle = localized(key: "labels.section.title.loans")
        /// accountsJourney.accountsList.labels.section.title.savingsAccounts
        public var savingsAccountTitle = localized(key: "labels.section.title.savingsAccounts")
        /// accountsJourney.accountsList.labels.section.title.termDeposits
        public var termDepositTitle = localized(key: "labels.section.title.termDeposits")
        /// accountsJourney.accountsList.labels.section.title.generalAccounts
        public var generalAccountTitle = localized(key: "labels.section.title.generalAccounts")
        /// accountsJourney.accountsList.labels.closed
        public var closedAccountSubtitle = localized(key: "labels.closed")
        /// accountsJourney.accountsList.labels.active
        public var activeAccountSubtitle = localized(key: "labels.active")
        /// accountsJourney.accountsList.labels.inactive
        public var inactiveAccountSubtitle = localized(key: "labels.inactive")
        /// accountsJourney.accountsList.errors.{error}.title
        public var errorTitle: ErrorFormatter<LocalizedString> = { error in
            switch error {
            case .noAccounts:
                localized(key: "errors.noAccounts.title")
            default:
                localized(key: "errors.generic.title")
            }
        }
        /// accountsJourney.accountsList.errors.{error}.subtitle
        public var errorSubtitle: ErrorFormatter<LocalizedString> = { error in
            switch error {
            case .noAccounts:
                localized(key: "errors.noAccounts.subtitle")
            default:
                localized(key: "errors.generic.subtitle")
            }
        }
        /// accountsJourney.accountsList.errors.{error}.actionButton.title
        public var errorRetryButtonTitle: ErrorFormatter<LocalizedString?> = { error in
            switch error {
            case .loadingFailure:
                localized(key: "errors.loadingFailure.actionButton")
            default:
                nil
            }
        }
        
        // MARK: - Private
        private static func localized(key: String) -> LocalizedString {
            let prefix = "accountsJourney.accountsList."
            return LocalizedString(key: prefix + key, in: .accountsJourney)
        }
    }
}
