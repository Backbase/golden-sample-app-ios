//
//  StateConfigurationView.swift
//  AccountsJourney
//

import BackbaseDesignSystem
import SwiftUI

/// SwiftUI replacement of the UIKit `StateView` for the empty and error states.
///
/// It renders a `StateViewConfiguration`, the same model the UIKit screens build with their view
/// model. The emblem appearance comes from `EmblemAppearance`, the same way it does for the account icons.
struct StateConfigurationView: View {

    let configuration: StateViewConfiguration
    let appearance: BB.Emblem.Appearance
    let accessibilityIdentifier: String

    var body: some View {
        BB.StateView(
            graphic: BB.Emblem(icon: icon, appearance: appearance, layout: .xLarge),
            labelPrimaryText: configuration.title,
            labelSecondaryText: configuration.subtitle.isEmpty ? nil : configuration.subtitle,
            primaryButton: button(for: configuration.firstButtonConfiguration),
            secondaryButton: button(for: configuration.secondButtonConfiguration),
            tertiaryButton: button(for: configuration.thirdButtonConfiguration)
        )
        .accessibilityIdentifier(accessibilityIdentifier)
    }

    private var icon: Image {
        Image.named(
            configuration.iconName ?? DesignSystem.Assets.icStateViewFailure,
            in: .accountsJourney, .design, .main
        )
    }

    private func button(for buttonConfiguration: ButtonConfiguration?) -> BB.Button? {
        buttonConfiguration.map { BB.Button(text: $0.title, action: $0.action) }
    }
}
