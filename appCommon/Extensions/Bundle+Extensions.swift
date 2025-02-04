//
//  Created by Backbase on 31/01/2024.
//

import UIKit

extension Bundle {
    public func localize(_ key: String) -> String? {
        let localised = localizedString(forKey: key, value: nil, table: "Localizable")
        if localised == key {
            return nil
        }
        return localised
    }
}

extension Bundle {
    static var appCommon: Bundle? {
        let podBundle = Bundle(for: BundleToken.self)
        guard let resourceUrl = podBundle.url(forResource: "Assets", withExtension: "bundle") else { return podBundle }
        guard let resourceBundle = Bundle(url: resourceUrl) else { return podBundle }
        return resourceBundle
    }
}

public final class BundleToken {
    // no code required
}
