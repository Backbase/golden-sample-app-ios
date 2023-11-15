//
//  AccountUiModel.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 26/10/2023.
//

import UIKit
import BackbaseDesignSystem


struct AccountUiModel {
    /// Unique id
    let id: String?
    /// Account name
    let name: String?
    /// Account balance
    let balance: Currency?
    /// State of account
    let state: String?
    /// Visibility status
    let isVisible: Bool?
    /// Name of the icon
    let iconName: AccountIconInfo?
    
    init(
        id: String? = nil,
        name: String? = nil,
        balance: Currency? = nil,
        state: String? = nil,
        isVisible: Bool? = nil,
        iconName: AccountIconInfo? = nil
    ) {
        self.id = id
        self.name = name
        self.balance = balance
        self.state = state
        self.isVisible = isVisible
        self.iconName = iconName
    }
}


public struct Currency: Equatable {
    /// Balance value as a string.
    var amount: String
    /// The alpha-3 code (complying with ISO 4217) of the currency that qualifies the amount.
    var currencyCode: String
    
    /// Initializer for the ``Currency`` DTO
    /// - Parameters:
    ///   - amount: balance as a string
    ///   - currencyCode: alpha-3 code (complying with ISO 4217) of the currency that qualifies the amount
    init(amount: String, currencyCode: String) {
        self.amount = amount
        self.currencyCode = currencyCode
    }
    
    init(amount: String?, currencyCode: String?) {
        if let amount, let currencyCode {
            self.amount = amount
            self.currencyCode = currencyCode
        } else {
            self.amount = "0"
            self.currencyCode = ""
        }
    }
}

/// `AccountIconInfo` DTO used in `AccountsJourney`
public struct AccountIconInfo: Equatable {
    /// Icon for the account
    let icon: UIImage
    /// Background color used when presenting the icon
    let backgroundColor: UIColor?
    
    /// Initializer for the `AccountIconInfo`
    /// - Parameters:
    ///   - icon: icon for the account
    ///   - backgroundColor: Background color used when presenting the icon
    public init?(icon: UIImage?, backgroundColor: UIColor? = nil) {
        guard let icon = icon else { return nil }
        self.icon = icon
        self.backgroundColor = backgroundColor
    }
    
    /// Initializer for the `AccountIconInfo`
    /// - Parameters:
    ///   - icon: icon for the account
    ///   - backgroundColor: Background color used when presenting the icon
    public init(icon: UIImage, backgroundColor: UIColor?) {
        self.icon = icon
        self.backgroundColor = backgroundColor
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.icon == rhs.icon && rhs.backgroundColor?.cgColor == rhs.backgroundColor?.cgColor
    }
}
