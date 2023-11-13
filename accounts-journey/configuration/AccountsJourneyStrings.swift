//
//  AccountsJourneyStrings.swift
//  AccountsJourney
//
//  Created by George Nyakundi on 06/11/2023.
//

import Foundation
//import RetailAppCommon

extension AccountsJourney {
    public struct Strings {
        /// Create a new strings object with default values
        public init() {
            // no code required
        }
        
        /// accountsJourney.accounts.labels.title
        public var screenTitle = localized(key: "labels.title")
        
        /// accountsJourney.accounts.labels.searchText
        public var searchText = localized(key: "labels.searchText")
        
        /// accountsJourney.accounts.labels.section.title.creditCards
        public var creditCardTitle = localized(key: "labels.section.title.creditCards")
        
        /// accountsJourney.accounts.labels.section.title.currentAccounts
        public var currentAccountTitle = localized(key: "labels.section.title.currentAccounts")
        
        /// accountsJourney.accounts.labels.section.title.debitCards
        public var debitCardTitle = localized(key: "labels.section.title.debitCards")
        
        /// accountsJourney.accounts.labels.section.title.investmentAccounts
        public var investmentAccountTitle = localized(key: "labels.section.title.investmentAccounts")
        
        /// accountsJourney.accounts.labels.section.title.loans
        public var loanAccountTitle = localized(key: "labels.section.title.loans")
        
        /// accountsJourney.accounts.labels.section.title.savingsAccounts
        public var savingsAccountTitle = localized(key: "labels.section.title.savingsAccounts")
        
        /// accountsJourney.accounts.labels.section.title.termDeposits
        public var termDepositTitle = localized(key: "labels.section.title.termDeposits")
        
        /// accountsJourney.accounts.labels.section.title.generalAccounts
        public var generalAccountTitle = localized(key: "labels.section.title.generalAccounts")
        
        /// accountsJourney.accounts.labels.closed
        public var closedAccountSubtitle = localized(key: "labels.closed")
    
        /// accountsJourney.accounts.labels.active
        public var activeAccountSubtitle = localized(key: "labels.active")
        
        /// accountsJourney.accounts.labels.inactive
        public var inactiveAccountSubtitle = localized(key: "labels.inactive")
        
        /// accountsJourney.accounts.errors.{error}.title
        public var errorTitle: ErrorFormatter<LocalizedString> = { error in
            switch error {
            case .noAccounts:
                localized(key: "errors.noAccounts.title")
            default:
                localized(key: "errors.generic.title")
            }
        }
        /// accountsJourney.accounts.errors.{error}.subtitle
        public var errorSubtitle: ErrorFormatter<LocalizedString> = { error in
            switch error {
            case .noAccounts:
                localized(key: "errors.noAccounts.subtitle")
            default:
                localized(key: "errors.generic.subtitle")
            }
        }
        /// accountsJourney.accounts.errors.{error}.actionButton.title
        public var errorRetryButtonTitle: ErrorFormatter<LocalizedString?> = { error in
            switch error {
            case .loadingFailure:
                return localized(key: "errors.loadingFailure.actionButton")
            default:
                return nil
            }
        }
        
        // MARK: - Private
        
        private static func localized(key: String) -> LocalizedString {
            let prefix = "accountsJourney.accounts."
            return LocalizedString(key: prefix + key, in: .accountsJourney)
        }
    }
}
