//
//  ShadowStyleModifier.swift
//  ios-golden-sample-app
//
//  Created by Aleh Pachtovy on 12/10/2026.
//

import BackbaseDesignSystem
import SwiftUI

/// A view modifier that applies shadow styling to views.
public struct ShadowStyleModifier: ViewModifier {

    /// Parameters for configuring shadow appearance.
    public struct ShadowParameters {

        /// The color of the shadow.
        let color: Color

        /// The blur radius of the shadow.
        let radius: CGFloat

        /// The horizontal offset of the shadow.
        let x: CGFloat

        /// The vertical offset of the shadow.
        let y: CGFloat

        /// Creates shadow parameters.
        /// - Parameters:
        ///   - color: The color of the shadow.
        ///   - radius: The blur radius of the shadow.
        ///   - x: The horizontal offset of the shadow.
        ///   - y: The vertical offset of the shadow.
        public init(
            color: Color,
            radius: CGFloat,
            x: CGFloat,
            y: CGFloat
        ) {
            self.color = color
            self.radius = radius
            self.x = x
            self.y = y
        }
    }

    var shadowParameters: ShadowParameters

    /// Applies the shadow styling to the content view.
    /// - Parameter content: The content view to style.
    /// - Returns: The styled view with shadow applied.
    public func body(content: Content) -> some View {
        content
            .shadow(
                color: shadowParameters.color,
                radius: shadowParameters.radius,
                x: shadowParameters.x,
                y: shadowParameters.y
            )
    }
}

extension ShadowStyleModifier.ShadowParameters {

    /// Maps a design-system shadow token to SwiftUI `.shadow` parameters.
    public static func designSystem(_ shadow: DesignSystem.Shadow) -> Self {
        .init(
            color: Color(shadow.color).opacity(Double(shadow.opacity)),
            radius: shadow.radius,
            x: shadow.offset.width,
            y: shadow.offset.height
        )
    }

    /// Shadow used by `DesignSystem.shared.styles.cardView` on `Card`.
    public static var cardView: Self {
        .designSystem(DesignSystem.shared.shadows.small)
    }
}

extension View {

    /// Applies shadow styling to a view with customizable shadow parameters.
    /// - Parameter shadowParameters: The shadow configuration. Defaults to the design-system card shadow.
    /// - Returns: A modified view with shadow styling applied.
    public func shadowStyle(
        shadowParameters: ShadowStyleModifier.ShadowParameters = .cardView
    ) -> some View {
        modifier(ShadowStyleModifier(shadowParameters: shadowParameters))
    }

    /// Mirrors `Card(DesignSystem.shared.styles.cardView)` surface + elevation.
    func cardViewStyle(
        backgroundColor: Color = Color(Theme.colors.background.surface1),
        cornerRadius: CGFloat = DesignSystem.shared.cornerRadius.large
    ) -> some View {
        background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .shadowStyle(shadowParameters: .cardView)
    }
}
