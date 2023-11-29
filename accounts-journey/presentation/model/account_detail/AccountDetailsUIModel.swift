//
//  AccountDetailsUIModel.swift
//  AccountsJourney
//
//  Created by George Nyakundi on 29/11/2023.
//

import Foundation

/// UI Model for Account Details
public struct AccountDetailsUIModel {
    /// Unique id
    let id: String
    /// Account name
    let name: String
    /// BBAN
    let BBAN: String
    /// Available balance
    let availableBalance: String
    /// Account holder names
    let accountHolderNames: String
    /// Product kind name
    let productKindName: String
    /// Bank branch code
    let bankBranchCode: String?
    /// Last Update date
    let lastUpdateDate: String
    /// Account interest rate
    let accountInterestRate: String?
    /// Accrued interest
    let accruedInterest: String
    /// Credit limit
    let creditLimit: String
    /// Account opening date
    let accountOpeningDate: String
    /// Name of the icon
    let iconName: AccountIconInfo?
}
