//
//  Created by Backbase on 31/01/2024.
//

import UIKit

extension Bundle {
    func localize(_ key: String) -> String? {
        let localised = localizedString(forKey: key, value: nil, table: "Localizable")
        if localised == key {
            return nil
        }
        return localised
    }
}
