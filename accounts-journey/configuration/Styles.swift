//
//  AccountsJourneyStyles.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 06/11/2023.
//

import UIKit
import Resolver
import BackbaseDesignSystem

extension AccountsJourney.Design {
    /// Configuration of styles used with the Accounts Journey
    public struct Styles {
        /// Style applied to account icon
        public var accountIconView: Style<IconView> = { view in
            DesignSystem.shared.styles.iconViewWithBackground(view)
            view.imageView.tintColor = UIColor(
                light: DesignSystem.shared.colors.charts.two.default.light,
                dark: DesignSystem.shared.colors.charts.two.lightest.dark
            )
            
            let width = view.widthAnchor.constraint(equalToConstant: DesignSystem.shared.sizer.xl)
            width.priority  = UILayoutPriority(rawValue: 999)
            let height = view.heightAnchor.constraint(equalToConstant: DesignSystem.shared.sizer.xl)
            height.priority = UILayoutPriority(rawValue: 999)
            NSLayoutConstraint.activate([
                width,
                height
            ])
        }
        
        /// Style applied to navigationBar
        public var navigationBar: Style<UINavigationBar> = { navigationBar in
            navigationBar.prefersLargeTitles = true
        }
        
        public var currencyFormatter: StyleSelector<(String, String), UILabel> = { values in
            return { label in
                let (amount, currencyCode) = values
                
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
