//
//  Created by Backbase on 7.12.2022.
//

import SnapshotTesting
import UIKit

extension UITraitCollection {

    static func getTraitCollection(_ orientation: ViewImageConfig.Orientation,
                                   _ layoutDirection: UITraitEnvironmentLayoutDirection,
                                   _ userInterfaceStyle: UIUserInterfaceStyle) -> UITraitCollection {
        let base: [UITraitCollection] = [
            .init(forceTouchCapability: .available),
            .init(layoutDirection: layoutDirection),
            .init(preferredContentSizeCategory: .medium),
            .init(userInterfaceIdiom: .phone),
            .init(userInterfaceStyle: userInterfaceStyle)
        ]

        switch orientation {
        case .landscape:
            return .init(
                traitsFrom: base + [
                    .init(horizontalSizeClass: .compact),
                    .init(verticalSizeClass: .compact)
                ]
            )
        case .portrait:
            return .init(
                traitsFrom: base + [
                    .init(horizontalSizeClass: .compact),
                    .init(verticalSizeClass: .regular)
                ]
            )
        @unknown default:
            fatalError("Fatal: unknown value for orientation")
        }
    }
}


extension ViewImageConfig.Orientation: CustomStringConvertible {
    /// Description used for assembling the file name of a reference snapshot
    public var description: String {
        switch self {
        case .landscape: return "landscape"
        case .portrait: return "portrait"
        @unknown default: return "unknownOrientation"
        }
    }
}

extension UIUserInterfaceStyle: CustomStringConvertible {
    /// Description used for assembling the file name of a reference snapshot
    public var description: String {
        switch self {
        case .light: return "light"
        case .dark: return "dark"
        case .unspecified: return "unspecifiedInterfaceStyle"
        @unknown default: return "unknownInterfaceStyle"
        }
    }
}

extension UITraitEnvironmentLayoutDirection: CustomStringConvertible {
    /// Description used for assembling the file name of a reference snapshot
    public var description: String {
        switch self {
        case .leftToRight: return "LTR"
        case .rightToLeft: return "RTL"
        case .unspecified: return "unspecifiedLayoutDirection"
        @unknown default: return "unknownLayoutDirection"
        }
    }
}
