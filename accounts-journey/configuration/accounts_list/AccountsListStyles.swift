//
//  AccountsListStyles.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 27/11/2023.
//

import UIKit
import Resolver
import BackbaseDesignSystem

extension AccountsList.Design {
    /// Configuration of styles used with the Accounts List Screen
    public struct Styles {
        /// Style applied to account groups
        public var accountGroup: Style<UIView> = { view in
            view.backgroundColor = .clear
        }
        /// Style applied to account group titles
        public var accountGroupTitle: Style<UILabel> = { label in
            label.font = DesignSystem.shared.fonts.preferredFont(.footnote, .regular)
            label.textColor = Theme.colors.foreground.support
        }
        /// Style applied to account icon
        public var accountIconView: Style<IconView> = { view in
            DesignSystem.shared.styles.iconViewWithBackground(view)
            view.imageView.tintColor = UIColor(
                light: Theme.colors.background.category2,
                dark: Theme.colors.background.category2Subtle
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
        /// Style applied to account name
        public var accountName: Style<UILabel> = { label in
            label.font = DesignSystem.shared.fonts.preferredFont(.subheadline, .semibold)
            label.textColor = Theme.colors.foreground.default
        }
        /// Style applied to account state
        public var accountState: Style<UILabel> = { label in
            label.font = DesignSystem.shared.fonts.preferredFont(.subheadline, .semibold)
            label.textColor = Theme.colors.foreground.support
        }
        /// Style applied to account balance
        public var accountBalance: Style<UILabel> = { label in
            label.font = DesignSystem.shared.fonts.preferredFont(.subheadline, .regular)
            label.textColor = Theme.colors.foreground.default
        }
        /// Style applied to navigationBar
        public var navigationBar: Style<UINavigationBar> = { navigationBar in
            navigationBar.prefersLargeTitles = true
        }
        /// Style applied to searchBar
        public var searchBar: Style<UISearchBar> = { searchBar in
            searchBar.searchTextField.textColor = Theme.colors.foreground.default
            searchBar.tintColor = Theme.colors.foreground.default
            searchBar.searchBarStyle = .minimal
        }
        /// Style applied to activityIndicator
        public var activityIndicator: StyleSelector<UIActivityIndicatorView.Style, UIActivityIndicatorView> = { style in
            return { activityIndicator in
                activityIndicator.style = style
            }
        }
    }
}
