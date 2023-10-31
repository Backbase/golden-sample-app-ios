//
//  AccountsListRowItem.swift
//  AccountsJourney
//
//  Created by George Nyakundi on 31/10/2023.
//

import Foundation
import BackbaseDesignSystem
import UIKit

public struct AccountsListRowItem {
    /// DTO that enables providing styleable text on an `AccountsListRowItem`
    public enum StyleableText {
        case text(String, Style<UILabel>?)
    }
    
    /// DTO that enables providing styleable icon on an `AccountsListRowItem`
    public enum StyleableIcon {
        /// Icon with associated style
        case icon(String, Style<IconView>?)
    }
    
    /// Unique identifier
    public let id: String?
    /// Account styleable icon
    public let accountIcon: StyleableIcon?
    /// Account name styleable text
    public let accountName: StyleableText?
    /// Account iban styleable text
    public let ibanLabel: StyleableText?
    /// Account balance styleable text
    public let accountBalance: StyleableText?
}
