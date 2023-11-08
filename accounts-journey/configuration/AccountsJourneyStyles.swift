//
//  AccountsJourneyStyles.swift
//  AccountsJourney
//
//  Created by George Nyakundi on 06/11/2023.
//

import UIKit
import Resolver
import BackbaseDesignSystem

extension AccountsJourney.Design {
    /// Configuration of styles used with the Accounts Journey
    public struct Styles {
        
        /// Style applied to account groups
        public var accountGroup: Style<UIView> = {view in
            view.backgroundColor = .clear
        }
        
        /// Style applied to account group titles
        public var accountGroupTitle: Style<UILabel> = { label in
            label.font = DesignSystem.shared.fonts.preferredFont(.footnote, .regular)
            label.textColor = DesignSystem.shared.colors.text.support
        }
        
        /// Style applied to account icon
        public var accountIconView: Style<IconView> = { view in
            DesignSystem.shared.styles.iconViewWithBackground(view)
            view.imageView.tintColor = UIColor(
                light: DesignSystem.shared.colors.charts.two.default.light,
                dark:DesignSystem.shared.colors.charts.two.lightest.dark
            )
        }
        /// Style applied to account name
        public var accountName: Style<UILabel> = { label in
            label.font = DesignSystem.shared.fonts.preferredFont(.subheadline, .semibold)
            label.textColor = DesignSystem.shared.colors.text.default
        }
        
        /// Style applied to account state
        public var accountState: Style<UILabel> = { label in
            label.font = DesignSystem.shared.fonts.preferredFont(.subheadline, .semibold)
            label.textColor = DesignSystem.shared.colors.text.support
        }
        
        /// Style applied to account balance
        public var accountBalance: Style<UILabel> = { label in
            label.font = DesignSystem.shared.fonts.preferredFont(.subheadline, .regular)
            label.textColor = DesignSystem.shared.colors.text.default
        }
        
        /// Style applied to navigationbar
        public var navigationBar: Style<UINavigationBar> = { navigationBar in
            navigationBar.prefersLargeTitles = true
        }
    
        public var currencyFormatter: StyleSelector<(String, String), UILabel> = { values in
            return { label in
                let (amount, currencyCode) = values
                let configuration: AccountsJourney.Configuration = Resolver.resolve()
                
                var amountOptions = DesignSystem.Formatting.Options()
                amountOptions.customCode = currencyCode
                amountOptions.minFractionDigits = DesignSystem.Formatting.defaultFractionDigits
                amountOptions.maxFractionDigits = DesignSystem.Formatting.defaultFractionDigits
                
                let formatter = DesignSystem.Formatting.makeFormatter()
               let numberLabel = formatter.format(amount: Decimal(string: amount) ?? 0.00, options: amountOptions)
                label.text = numberLabel
                label.accessibilityLabel = numberLabel
            }
        }
    }
}
