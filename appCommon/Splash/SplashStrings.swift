//
//  SplashStrings.swift
//  AppCommon
//
//  Created by George Nyakundi on 04/02/2025.
//

import Foundation
import RetailJourneyCommon

public extension Splash {
    /// Top level configuration for the strings displayed on the Splash screen
    struct Strings {
        /// Initializer that loads the default values for the strings used on the Splash screen
        public init() {
            // no code required
        }

        /// Splash screen title. Defaults to `nil`
        public var title: LocalizedString?

        /// Splash screen subtitle. Defaults to `nil`
        public var subtitle: LocalizedString?
    }
}
