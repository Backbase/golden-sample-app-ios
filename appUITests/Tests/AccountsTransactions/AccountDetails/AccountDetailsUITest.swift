//
//  AccountDetailsUITest.swift
//  ios-golden-sample-app
//
//  Created by George Nyakundi on 08/07/2025.
//

import XCTest

extension AccountsJourneyUITests {

    func test_account_details_screen_is_displayed_upon_selecting_account() {
        AccountsListScreen(app)
            .tapAccount(named: AccountsListTestData.defaultAccountName)
            .assertAccountDetailsIsDisplayed()
            .assertErrorIsNotDisplayed()
    }

    func test_account_details_header_shows_the_selected_account() {
        AccountsListScreen(app)
            .tapAccount(named: AccountsListTestData.defaultAccountName)
            .assertAccountDetailsIsDisplayed()
            .assertHeaderIsDisplayed(
                productKind: AccountDetailsTestData.defaultProductKind,
                accountNumber: AccountsListTestData.defaultAccountNumber
            )
    }

    func test_account_details_sections_show_the_selected_account() {
        AccountsListScreen(app)
            .tapAccount(named: AccountsListTestData.defaultAccountName)
            .assertAccountDetailsIsDisplayed()
            // Details section
            .assertRowIsDisplayed(
                title: AccountDetailsTestData.holderNamesTitle,
                value: AccountsListTestData.defaultAccountName
            )
            .assertRowIsDisplayed(
                title: AccountDetailsTestData.cardOrAccountNumberTitle,
                value: AccountsListTestData.defaultAccountNumber
            )
            // General section
            .assertSectionTitleIsDisplayed(AccountDetailsTestData.generalSectionTitle)
            .assertRowIsDisplayed(
                title: AccountDetailsTestData.accountTypeTitle,
                value: AccountDetailsTestData.defaultProductKind
            )
            .assertRowIsDisplayed(
                title: AccountDetailsTestData.accountNameTitle,
                value: AccountDetailsTestData.defaultProductKind
            )
            // Status section
            .assertSectionTitleIsDisplayed(AccountDetailsTestData.statusSectionTitle)
            .assertRowIsDisplayed(
                title: AccountDetailsTestData.accountStatusTitle,
                value: AccountDetailsTestData.defaultAccountStatus
            )
    }

    func test_back_from_account_details_returns_to_the_accounts_list() {
        AccountsListScreen(app)
            .tapAccount(named: AccountsListTestData.defaultAccountName)
            .assertAccountDetailsIsDisplayed()
            .tapBackToAccountsList()
            .assertAccountScreenIsDisplayed()
    }
}
