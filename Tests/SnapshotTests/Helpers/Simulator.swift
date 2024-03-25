//
// Copyright © 2022 Backbase R&D B.V. All rights reserved.
//

import SnapshotTesting
import UIKit

/// https://www.paintcodeapp.com/news/ultimate-guide-to-iphone-resolutions
enum Simulator: CaseIterable {

    case iPhone8(ViewImageConfig)

    case iPhone11(ViewImageConfig)

    case iPhone14ProMax(ViewImageConfig)


    /// The `ViewImageConfig` associated with the enum case
    var config: ViewImageConfig {
        switch self {
        case let .iPhone8(config): return config
        case let .iPhone11(config): return config
        case let .iPhone14ProMax(config): return config
        }
    }

    /// The orientation of the Simulator
    fileprivate var orientation: ViewImageConfig.Orientation {
        guard let size = config.size else { fatalError() }
        if size.width < size.height {
            return .portrait
        } else if size.width > size.height {
            return .landscape
        } else {
            fatalError()
        }
    }
}

extension Simulator {

    /// LTR + Light mode only.
    static var leftToRightLightMode: [Simulator] = [
        .iPhone11(.get11sConfig(.portrait, .leftToRight, .light))
    ]

    /// RTL + Light mode only.
    static var rightToLeftLightMode: [Simulator] = [
        .iPhone11(.get11sConfig(.portrait, .rightToLeft, .light))
    ]

    /// Includes test cases for all cases, leftToRight, rightToLeft, light and dark mode.
    static var allCases: [Simulator]  = [
        .iPhone11(.get11sConfig(.portrait, .leftToRight, .light)),
        .iPhone11(.get11sConfig(.portrait, .leftToRight, .dark)),
        .iPhone11(.get11sConfig(.portrait, .rightToLeft, .light))
    ]

    /// LTR + Light and dark mode.
    static var leftToRightWithDarkMode: [Simulator]  = [
        .iPhone11(.get11sConfig(.portrait, .leftToRight, .light)),
        .iPhone11(.get11sConfig(.portrait, .leftToRight, .dark))
    ]

    /// LTR + dark mode.
    static var leftToRightDarkMode: [Simulator]  = [
        .iPhone11(.get11sConfig(.portrait, .leftToRight, .dark))
    ]

    /// Includes test cases for light mode only for leftToRight and rightToLeft.
    static var lightOnly: [Simulator] = [
        .iPhone11(.get11sConfig(.portrait, .leftToRight, .light)),
        .iPhone11(.get11sConfig(.portrait, .rightToLeft, .light))
    ]
}

extension Simulator: CustomStringConvertible {

    /// Used for assembling the file name of a reference snapshot
    private var name: String {
        switch self {
        case .iPhone8: return "iPhone8"
        case .iPhone11: return "iPhone11"
        case .iPhone14ProMax: return "iPhone14ProMax"
        }
    }

    /// Used to name the file of a reference snapshot for the view controllers
    var description: String {
        return [
            name,
            "\(orientation.description)",
            "\(config.traits.userInterfaceStyle.description)",
            "\(config.traits.layoutDirection.description)"
        ].joined(separator: "_")
    }

    /// Used to name the file of a reference snapshot for the views.
    var viewDescription: String {
        return [
            "\(config.traits.userInterfaceStyle.description)",
            "\(config.traits.layoutDirection.description)"
        ].joined(separator: "_")
    }
}

fileprivate extension ViewImageConfig {
    static func get8sConfig(_ orientation: Orientation,
                            _ layoutDirection: UITraitEnvironmentLayoutDirection,
                            _ userInterfaceStyle: UIUserInterfaceStyle) -> ViewImageConfig {
        let safeArea: UIEdgeInsets
        let size: CGSize
        switch orientation {
        case .landscape:
            safeArea = .zero
            size = .init(width: 667, height: 375)
        case .portrait:
            safeArea = .init(top: 20, left: 0, bottom: 0, right: 0)
            size = .init(width: 375, height: 667)
        @unknown default:
            fatalError("Fatal: unknown value for orientation")
        }
        return .init(safeArea: safeArea, size: size, traits: .getTraitCollection(orientation, layoutDirection, userInterfaceStyle))
    }

    static func get11sConfig(_ orientation: Orientation,
                             _ layoutDirection: UITraitEnvironmentLayoutDirection,
                             _ userInterfaceStyle: UIUserInterfaceStyle) -> ViewImageConfig {
        let safeArea: UIEdgeInsets
        let size: CGSize
        switch orientation {
        case .landscape:
            safeArea = .init(top: 0, left: 44, bottom: 24, right: 44)
            size = .init(width: 896, height: 414)
        case .portrait:
            safeArea = .init(top: 44, left: 0, bottom: 34, right: 0)
            size = .init(width: 414, height: 896)
        @unknown default:
            fatalError("Fatal: unknown value for orientation")
        }
        return .init(safeArea: safeArea, size: size, traits: .getTraitCollection(orientation, layoutDirection, userInterfaceStyle))
    }

    static func get14ProMaxsConfig(_ orientation: Orientation,
                                   _ layoutDirection: UITraitEnvironmentLayoutDirection,
                                   _ userInterfaceStyle: UIUserInterfaceStyle) -> ViewImageConfig {
        let safeArea: UIEdgeInsets
        let size: CGSize
        switch orientation {
        case .landscape:
            safeArea = .init(top: 0, left: 59, bottom: 24, right: 59)
            size = .init(width: 932, height: 430)
        case .portrait:
            safeArea = .init(top: 59, left: 0, bottom: 34, right: 0)
            size = .init(width: 430, height: 932)
        @unknown default:
            fatalError("Fatal: unknown value for orientation")
        }
        return .init(safeArea: safeArea, size: size, traits: .getTraitCollection(orientation, layoutDirection, userInterfaceStyle))
    }
}
