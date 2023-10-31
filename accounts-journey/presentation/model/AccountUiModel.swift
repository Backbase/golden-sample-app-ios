//
//  AccountUiModel.swift
//  AccountsJourney
//
//  Created by George Nyakundi on 26/10/2023.
//

import Foundation


struct AccountUiModel {
    /// Unique id
    let id: String?
    /// Account name
    let name: String?
    /// Account balance
    let balance: String?
    /// State of account
    let state: String?
    /// IBAN of account
    let iban: String?
    /// Visibility status
    let isVisible: Bool?
    /// Name of the icon
    let iconName: String?
    
    init(
        id: String? = nil,
        name: String? = nil,
        balance: String? = nil,
        state: String? = nil,
        iban: String? = nil,
        isVisible: Bool? = nil,
        iconName: String? = nil
    ) {
        self.id = id
        self.name = name
        self.balance = balance
        self.state = state
        self.iban = iban
        self.isVisible = isVisible
        self.iconName = iconName
    }
}
