//
//  LocalizedString.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 07/11/2023.
//

import Foundation

public struct LocalizedString: ExpressibleByStringLiteral {
    /// Value of the localized string
    var value: String { callAsFunction() }
    
    public init(stringLiteral value: String) {
        self = LocalizedString(key: value)
    }
    
    public init(key: String, in bundles: Bundle?...) {
        self.key = key
        self.bundles = ([.main] + bundles).compactMap { $0 }
    }
    
    func callAsFunction() -> String {
        return bundles
            .compactMap { bundle -> String? in
                let localized = bundle.localizedString(
                    forKey: key,
                    value: key, table: nil
                )
                if localized == key { return nil }
                return localized
            }
            .first ?? key
    }
    
    let key: String
    let bundles: [Bundle]
    
}
