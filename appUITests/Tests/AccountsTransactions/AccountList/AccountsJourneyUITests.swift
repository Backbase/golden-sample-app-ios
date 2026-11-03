//
//  AccountsJourneyUITests.swift
//  ios-golden-sample-app
//
//  Created by George Nyakundi on 08/07/2025.
//

import XCTest

final class AccountsJourneyUITests: BaseTestCase {
    func test_account_is_displayed_in_the_list() {
        AccountsListScreen(app)
            .assertAccountScreenIsDisplayed()
            .assertAccountIsDisplayed(
                name: AccountsListTestData.defaultAccountName,
                accountNumber: AccountsListTestData.defaultAccountNumber
            )
    }

    func test_account_list_is_still_displayed_after_pull_to_refresh() {
        AccountsListScreen(app)
            .assertAccountScreenIsDisplayed()
            .pullToRefresh()
            .assertAccountScreenIsDisplayed()
            .assertAccountIsDisplayed(
                name: AccountsListTestData.defaultAccountName,
                accountNumber: AccountsListTestData.defaultAccountNumber
            )
    }
}
