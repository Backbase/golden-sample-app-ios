//
//  AccountDetailsUITest.swift
//  ios-golden-sample-app
//
//  Created by George Nyakundi on 08/07/2025.
//

extension AccountsJourneyUITests {
    func test_account_details_screen_is_displayed_upon_selecting_account() {
        AccountsListScreen(app)
            .tapFirstAccount()
            .assertAccountDetailsIsDisplayed()
    }
}
