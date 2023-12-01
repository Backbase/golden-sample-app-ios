//
//  AccountDetailsRowItem.swift
//  AccountsJourney
//
//  Created by George Nyakundi on 29/11/2023.
//

import UIKit
import BackbaseDesignSystem

public struct AccountDetailsRowItem {
    public enum StyleableText {
        case text(String, Style<UILabel>?)
        case currency(Currency, StyleSelector<(String, String), UILabel>)
    }
    
    public let title: StyleableText
    public let subTitle: StyleableText
}

public struct AccountDetailsSection {
    // Title of the Card section
    public let title: String?
    /// Contents to be displayed within the card
    public let rows: [AccountDetailsRowItem]
    
    public init(title: String? = nil, rows: [AccountDetailsRowItem]) {
        self.title = title
        self.rows = rows
    }
}
