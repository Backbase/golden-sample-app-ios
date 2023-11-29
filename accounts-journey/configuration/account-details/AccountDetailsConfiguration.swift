//
//  AccountDetailsConfiguration.swift
//  AccountsJourney
//
//  Created by George Nyakundi on 29/11/2023.
//

import Foundation

extension AccountDetails {
    public struct Configuration {
        public init() {
            // no code required
        }
        
        /// Configuration of strings used in Account Details
        public var strings = Strings()
        
        /// Configuration of design used in Account Details
        public var design = Design()
    }
}
