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
    public let value: StyleableText
    public let iconConfig: AccountIconInfo?
}

public struct AccountDetailsSection {
    public let title: String?
    public let rows: [AccountDetailsRowItem]
    
    public init(title: String?, rows: [AccountDetailsRowItem]) {
        self.title = title
        self.rows = rows
    }
    
    public init(title: String?, rows: [AccountDetailsRowItem], isShareAvailable: Bool) {
        self.title = title
        self.rows = rows
    }
}

public protocol AccountDetailsSectionsProvider {
    var sections: [AccountDetailsSection] { get }
}
