//
//  AccountsListRowItem.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 31/10/2023.
//

import Foundation
import BackbaseDesignSystem
import UIKit

public struct AccountsListRowItem {
    /// DTO that enables providing styleable text on an `AccountsListRowItem`
    public enum StyleableText {
        case text(String, Style<UILabel>?)
        case currency(Currency, StyleSelector<(String, String),UILabel>)
    }
    
    /// Unique identifier
    public let id: String?
    /// Account styleable icon
    public let accountIcon: AccountIconInfo?
    /// Account name styleable text
    public let accountName: StyleableText?
    /// Account state styleable text
    public let stateLabel: StyleableText?
    /// Account balance styleable text
    public let accountBalance: StyleableText?
}
