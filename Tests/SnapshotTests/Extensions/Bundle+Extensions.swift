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

extension Bundle {
    /// Helper function to return contents of a file in data format
    /// - Parameter path: path of the file
    /// - Returns: data format of the contents
    static func data(from path: String) -> Data {
        guard let filePath = Bundle(for: AccountDetailsScreenSnapshotTests.self).path(forResource: path, ofType: nil) else {
            fatalError("Failed to find file \(path)")
        }
        let fileUrl = URL(fileURLWithPath: filePath)
        do {
            let data = try Data(contentsOf: fileUrl, options: .uncached)
            return data
        } catch {
            fatalError("Failed to find file \(path)")
        }
    }
}
