//
// Copyright © 2020 Backbase R&D B.V. All rights reserved.
//

import UIKit

extension Bundle {
    static var snapshot: Bundle? {
        return Bundle(for: BundleToken.self)
    }
}

private final class BundleToken {}
