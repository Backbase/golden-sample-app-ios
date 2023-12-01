//
//  AccountDetailsStyles.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 29/11/2023.
//

import UIKit
import BackbaseDesignSystem

extension AccountDetails.Design {
    /// Configuration of styles used with the Account Details screen
    public struct Styles {
        
        /// Style applied to account detail sectionTitle
        public var accountDetailSectionTitle: Style<UILabel> = { label in
            label.font = DesignSystem.shared.fonts.preferredFont(.footnote, .regular)
            
            label.textColor = DesignSystem.shared.colors.text.support
        }
        
        /// Style applied to account detail row item title
        public var accountDetailRowItemTitle: Style<UILabel> = { label in
            label.font = DesignSystem.shared.fonts.preferredFont(.subheadline, .semibold)
            label.textColor = DesignSystem.shared.colors.text.default
        }
        
        /// Style applied to account detail row item title
        public var accountDetailRowItemSubtitle: Style<UILabel> = { label in
            label.font = DesignSystem.shared.fonts.preferredFont(.subheadline, .semibold)
            label.textColor = DesignSystem.shared.colors.text.support
        }
    }
}
