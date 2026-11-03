//
//  AccountDetailsStyles.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 29/11/2023.
//

import UIKit
import Resolver
import BackbaseDesignSystem

extension AccountDetails.Design {
    /// Configuration of styles used with the Account Details screen
    public struct Styles {
        /// Style applied to account detail sectionTitle
        public var accountDetailSectionTitle: Style<UILabel> = { label in
            label.font = DesignSystem.shared.fonts.preferredFont(.footnote, .regular)
            label.textColor = Theme.colors.foreground.support
        }
        /// Style applied to account detail row item title
        public var accountDetailRowItemTitle: Style<UILabel> = { label in
            label.font = DesignSystem.shared.fonts.preferredFont(.subheadline, .semibold)
            label.textColor = Theme.colors.foreground.default
        }
        /// Style applied to account detail row item title
        public var accountDetailRowItemSubtitle: Style<UILabel> = { label in
            label.font = DesignSystem.shared.fonts.preferredFont(.subheadline, .semibold)
            label.textColor = Theme.colors.foreground.support
        }
        /// Style applied to account detail navigationBar
        public var navigationBar: Style<UINavigationBar> = { navigationBar in
            navigationBar.tintColor = Theme.colors.foreground.default
        }
        /// Style applied to account detail navigationItem
        public var navigationItem: Style<UINavigationItem> = { navigationItem in
            navigationItem.largeTitleDisplayMode = .never
        }
    }
}
