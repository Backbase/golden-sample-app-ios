//
//  AccountDetailsStyles.swift
//  AccountsJourney
//
//  Created by George Nyakundi on 29/11/2023.
//

import UIKit
import BackbaseDesignSystem

extension AccountDetails.Design {
    /// Configuration of styles used with the Account Details screen
    public struct Styles {
        /// Style applied to navigationBar
        public var navigationBar: Style<UINavigationBar> = { navigationBar in
            navigationBar.prefersLargeTitles = true
        }
    }
}
