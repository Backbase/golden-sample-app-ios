//
//  UserPreferences.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 11/10/2023.
//

import Foundation

extension AccountsJourney {
   
    /// User defined preferences for a specific arrangement. Note: each user might have different preferences.
    public struct UserPreferences: Equatable {
        /// The name that can be assigned by the user to label the arrangement.
        public let alias: String?
        /// User indicator whether to show or hide the arrangement on the front end.
        public let visible: Bool?
        /// Indication whether an arrangement can be favorable for a user.
        public let favorite: Bool?
        /// Additional fields.
        public let additions: [String: String]?
        
        /// Create a new `UserPreferences` object.
        /// - Parameters:
        ///   - alias: Optional alias. Defaults to `nil`
        ///   - visible: Optional visible. Defaults to `nil`
        ///   - favorite: Optional favorite. Defaults to `nil`
        ///   - additions: Optional additions. Defaults to `nil`
        public init(alias: String? = nil,
                    visible: Bool? = nil,
                    favorite: Bool? = nil,
                    additions: [String: String]? = nil
        ) {
            self.alias = alias
            self.visible = visible
            self.favorite = favorite
            self.additions = additions
        }
    }

}
