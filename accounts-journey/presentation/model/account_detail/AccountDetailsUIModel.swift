//
//  AccountDetailsUIModel.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 29/11/2023.
//

import Foundation

/// UI Model for Account Details
public struct AccountDetailsUIModel {
    /// Unique id
    let id: String
    /// Account name
    let name: String
    /// Display name
    let displayName: String
    /// BBAN
    let BBAN: String
    /// Currency
    let currency: String
    /// Available balance
    let availableBalance: Double
    /// Account holder names
    let accountHolderNames: String
    /// Product kind name
    let productKindName: String
    /// Product type name
    let productTypeName: String
    /// Bank branch code
    let bankBranchCode: String?
    /// Last Update date
    let lastUpdateDate: String
    /// Account interest rate
    let accountInterestRate: String?
    /// Accrued interest
    let accruedInterest: Double
    /// Credit limit
    let creditLimit: Double
    /// Account opening date
    let accountOpeningDate: String
    /// Account state
    let accountState: String?
    /// Name of the icon
    let iconName: AccountIconInfo?
}
