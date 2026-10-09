//
//  CustomProgressView.swift
//  AccountsJourney
//

import BackbaseDesignSystem
import SwiftUI

/// SwiftUI replacement of the UIKit `LoadingView`: a large spinner centered on the surface background.
struct CustomProgressView: View {

    var backgroundColor: Color

    var body: some View {
        ProgressView()
            .controlSize(.large)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(backgroundColor)
            .accessibilityIdentifier("CustomProgressView.spinner")
    }

    public init(backgroundColor: Color = .clear) {
        self.backgroundColor = backgroundColor
    }
}

#if DEBUG
#Preview("Loading") {
    CustomProgressView()
        .padding(.horizontal, DesignSystem.shared.spacer.md)
        .background(Color(Theme.colors.background.page))
}
#endif
