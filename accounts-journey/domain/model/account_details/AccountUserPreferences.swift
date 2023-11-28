//
//  AccountUserPreferences.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 28/11/2023.
//

import Foundation

extension AccountsJourney {
    /// User defined preferences for a specific arrangement
    public struct AccountUserPreferences: Equatable {
        /// The unique arrangement identifier related to these user preference
        public let arrangementId: String
        /// The name that can be assigned by the user to label the arrangement
        public let alias: String?
        /// User indicator whether to show or hide the arrangement on the front end
        public let visible: Bool?
        /// Indication whether an arrangement can be favorable for a user
        public let favorite: Bool?
        /// Additional fields
        public let additions: [String: String]?
        
        /// Initializer for the `AccountUserPreference` DTO
        /// - Parameters:
        ///   - arrangementId: unique arrangement identifier
        ///   - alias: name assigned by the user
        ///   - visible: indicator to show or hide arrangement
        ///   - favorite: indication whether arrangement is a favorite
        ///   - additions: additional fields
        public init(arrangementId: String,
                    alias: String?,
                    visible: Bool?,
                    favorite: Bool?,
                    additions: [String: String]?
        ) {
            self.arrangementId = arrangementId
            self.alias = alias
            self.visible = visible
            self.favorite = favorite
            self.additions = additions
        }
    }
}
