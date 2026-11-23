//
//  SearchAccountsUITests.swift
//  ios-golden-sample-app
//
//  Created by George Nyakundi on 08/07/2025.
//
extension AccountsJourneyUITests {
    func test_account_search_results_are_displayed() {
        AccountsListScreen(app)
            .searchAccount(query: AccountsListTestData.defaultAccountName)
            .assertAccountIsDisplayed(name: AccountsListTestData.defaultAccountName, accountNumber: AccountsListTestData.defaultAccountNumber)
            // The search filters the list, accounts that do not match the query are gone.
            .assertAccountIsNotDisplayed(name: AccountsListTestData.otherAccountName)
    }
    
    func test_account_empty_search_results_displayed_for_non_existent_account() {
        AccountsListScreen(app)
            .searchAccount(query: AccountsListTestData.dummyInexistentAccount)
            .assertNoResultsDisplayed()
    }
}
