//
//  AccountsListTestData.swift
//  GoldenSampleUITests
//
//  Created by Backbase on 15/01/2024.
//

import Foundation

struct AccountsListTestData {
    // NOTE : Please adjust this based on the test data available
    static let defaultAccountName = "Ashok's Current Account 1"
    static let defaultAccountNumber = "****************1033"
    static let defaultBalance = ""
    /// An account that does not match `defaultAccountName`, to prove that a search filters the list.
    static let otherAccountName = "Ashok's Savings Account 1"
    static let dummyInexistentAccount = "Tomorrow never comes"
    static let noAccountsLabel = "No accounts"
    static let ohhShootLabel = "Ohhh Shooot"
    static let somethingWentWrongLabel = "Something wrong happened"
    static let couldNotPullToRefresh = "Could not pull to refresh"
}

struct AccountDetailsTestData {
    // Localized texts of the screen, see `accountsJourney.accountDetails.*` in Localizable.xcstrings
    static let screenTitle = "Account Details"
    static let limitTitle = "Limit"
    static let holderNamesTitle = "Holder Name(s)"
    static let cardOrAccountNumberTitle = "Card / Account Number"
    static let generalSectionTitle = "General"
    static let accountTypeTitle = "Account Type"
    static let accountNameTitle = "Account Name"
    static let statusSectionTitle = "Status"
    static let accountStatusTitle = "Account / Product Status"

    // NOTE : Please adjust this based on the test data available, it describes `AccountsListTestData.defaultAccountName`
    static let defaultProductKind = "Current Account"
    static let defaultAccountStatus = "Active"
}
