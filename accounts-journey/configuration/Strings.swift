//
//  AccountsJourneyStrings.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 06/11/2023.
//

import Foundation

extension AccountsJourney {
    public struct Strings {
        /// Create a new strings object with default values
        public init() {
            // no code required
        }
        
        // MARK: - Private
        private static func localized(key: String) -> LocalizedString {
            let prefix = "accountsJourney."
            return LocalizedString(key: prefix + key, in: .accountsJourney)
        }
    }
}
