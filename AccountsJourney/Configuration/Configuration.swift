//
//  AccountsJourneyConfiguration.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 11/10/2023.
//

import UIKit
import Resolver
import BackbaseDesignSystem

extension AccountsJourney {
    public struct Configuration {
        /// Create a new Configuration object with default values
        public init() {
            // no code required
        }
        /// Configuration for ``AccountsList`` screen
        public var accountsList = AccountsList.Configuration()
        
        /// Configuration for ``accountDetails`` screen
        public var accountDetails = AccountDetails.Configuration()
        
        /// Configuration of styles used in the Accounts Journey
        public var design = Design()
    }
}
