//
//  AccountsListRowButtonStyle.swift
//  AccountsJourney
//

import BackbaseDesignSystem
import SwiftUI

/// The row surface, tinted while the row is pressed.
///
/// `.plain` has no pressed state, so a tap would give no feedback before the push to Account Details.
/// The surface is drawn here, behind the row, so the highlight replaces it instead of covering the content.
struct AccountsListRowButtonStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? Self.pressedColor : Self.surfaceColor)
    }

    private static let surfaceColor = Color(Theme.colors.background.surface1)

    /// What the UIKit cell used as its selected background.
    private static let pressedColor = Color(UIColor(light: Theme.colors.background.brandSubtle, dark: Theme.colors.background.brand))
}
