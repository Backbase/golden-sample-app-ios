//
//  ViewStateContainer.swift
//  AccountsJourney
//

import BackbaseDesignSystem
import SwiftUI

/// Renders a `ViewState`: a spinner while loading, the content once loaded, and the state view
/// of its configuration when the load failed.
struct ViewStateContainer<DataType, Content: View>: View {

    let state: ViewState<DataType>
    let errorAppearance: BB.Emblem.Appearance
    let errorAccessibilityIdentifier: String
    @ViewBuilder let content: (DataType) -> Content

    var body: some View {
        switch state {
        case .loading:
            CustomProgressView()
                .padding(.horizontal, DesignSystem.shared.spacer.md)
        case let .loaded(data):
            content(data)
        case let .error(configuration):
            StateConfigurationView(
                configuration: configuration,
                appearance: errorAppearance,
                accessibilityIdentifier: errorAccessibilityIdentifier
            )
            .padding(.horizontal, DesignSystem.shared.spacer.md)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
