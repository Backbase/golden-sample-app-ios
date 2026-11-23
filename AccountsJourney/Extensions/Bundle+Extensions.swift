//
//  Bundle+Extensions.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 07/11/2023.
//

import Foundation

private final class AccountsJourneyBundleToken { }

extension Bundle {
    public static var accountsJourney: Bundle? {
        let bundle = Bundle(for: AccountsJourneyBundleToken.self)
        
        guard let resourceUrl = bundle.url(forResource: "AccountsJourneyAssets", withExtension: "bundle"), let resourceBundle = Bundle(url: resourceUrl) else {
            return bundle
        }
        
        return resourceBundle
    }
}
