//
//  SplashDesign.swift
//  AppCommon
//
//  Created by George Nyakundi on 04/02/2025.
//

import UIKit
import BackbaseDesignSystem

public extension Splash {
    /// Top level design configuration of the splash screen.
    struct Design {
        /// Initializer that loads the default style of the splash screen.
        public init() {
            // no code required
        }

        /// Style of the logo displayed on the Splash screen
        public var logo: Style<UIImageView> = { imageView in
            imageView.tintColor = .white
        }

        /// Style of the title text displayed on the Splash screen
        public var title: Style<UILabel> = { label in
            label.font = .systemFont(ofSize: 32, weight: .bold)
            label.textColor = .white
            label.textAlignment = .center
            label.numberOfLines = 0
        }

        /// Style of the subtitle text displayed on the Splash screen
        public var subtitle: Style<UILabel> = { label in
            label.font = .systemFont(ofSize: 32, weight: .light)
            label.textColor = .white
            label.textAlignment = .center
            label.numberOfLines = 0
        }

        /// Style of the activity indicator displayed on the Splash screen
        public var indicator = DesignSystem.shared.styles.loadingIndicator
    }
}
