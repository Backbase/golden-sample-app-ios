//
//  AccountSummaryUiModel.swift
//  AccountsJourney
//
//  Created by George Nyakundi on 26/10/2023.
//

import Foundation

struct AccountSummaryUiModel {
    let customProducts: [AccountsUiModel]
    let currentAccounts: AccountsUiModel?
    let savingAccounts: AccountsUiModel?
    let termDeposits: AccountsUiModel?
    let loans: AccountsUiModel?
    let creditCards: AccountsUiModel?
    let debitCards: AccountsUiModel?
    let investmentAccounts: AccountsUiModel?
}
