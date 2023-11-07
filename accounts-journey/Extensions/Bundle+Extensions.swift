//
//  Bundle+Extensions.swift
//  AccountsJourney
//
//  Created by George Nyakundi on 07/11/2023.
//

import Foundation

extension Bundle {
    static var accountsJourney: Bundle? {
        let bundle = Bundle(for: AccountsJourneyBundleToken.self)
        
        guard let resourceUrl = bundle.url(forResource: "AccountsJourneyAssets", withExtension: "bundle"), let resourceBundle = Bundle(url: resourceUrl) else {
            return bundle
        }
        
        return resourceBundle
    }
}
