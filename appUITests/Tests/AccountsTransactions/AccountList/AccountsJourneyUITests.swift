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
    }
}
