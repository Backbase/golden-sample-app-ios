//
//  EmblemAppearance.swift
//  ios-golden-sample-app
//
//  Created by Aleh Pachtovy on 09/10/2026.
//

import BackbaseDesignSystem
import SwiftUI

/// Picks the `BB.Emblem` appearance for an icon background colour.
///
/// `BB.Emblem` is themed through `Appearance` rather than an arbitrary colour, so the background
/// is matched (by its light-mode value) with the design system `*Subtle` background tokens.
/// Unknown colours fall back to `.neutral`.
enum EmblemAppearance {

    static func appearance(for color: Color?) -> BB.Emblem.Appearance {
        guard let color else { return .neutral }
        let resolved = resolve(color)
        return candidates.first { resolve($0.color) == resolved }?.appearance ?? .neutral
    }

    /// Same as ``appearance(for:)``, for the `UIColor` tokens the design system and the account
    /// icons (`AccountIconInfo.backgroundColor`) are expressed in.
    static func appearance(forBackground color: UIColor?) -> BB.Emblem.Appearance {
        appearance(for: color.map(Color.init(uiColor:)))
    }

    private static func resolve(_ color: Color) -> Color.Resolved {
        var environment = EnvironmentValues()
        environment.colorScheme = .light
        return color.resolve(in: environment)
    }

    private static var candidates: [(appearance: BB.Emblem.Appearance, color: Color)] {
        let background = Theme.colors.background
        return [
            (.brand, Color(background.brandSubtle)),
            (.info, Color(background.infoSubtle)),
            (.success, Color(background.successSubtle)),
            (.warning, Color(background.warningSubtle)),
            (.danger, Color(background.dangerSubtle)),
            (.neutral, Color(background.neutralSubtle)),
            (.category1, Color(background.category1Subtle)),
            (.category2, Color(background.category2Subtle)),
            (.category3, Color(background.category3Subtle)),
            (.category4, Color(background.category4Subtle)),
            (.category5, Color(background.category5Subtle)),
            (.category6, Color(background.category6Subtle)),
            (.category7, Color(background.category7Subtle)),
            (.category8, Color(background.category8Subtle)),
            (.category9, Color(background.category9Subtle)),
            (.category10, Color(background.category10Subtle))
        ]
    }
}
