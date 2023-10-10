//
//  Created by Backbase on 03/07/2023.
//

import Foundation

public struct Variants {
    static let configuration: [String: Any] = {
        guard let infoDictionary = Bundle.main.infoDictionary else {
            fatalError("Info.plist file not found")
        }
        return infoDictionary
    }()
}
