//
//  AccountsListL2Tests.swift
//  ios-golden-sample-app
//
//  Created by George Nyakundi on 27/05/2025.
//
import XCTest
import Foundation
import Resolver
import AccountsJourney

final class AccountsListL2Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        self.continueAfterFailure = false
    }
    
    func testAccountIsDisplayedInTheList() {
        Launcher()
            .launchApp()
            .assertAccountScreenIsDisplayed()
    }
    
    func testCorrectSearchResultIsDisplayed() {
        Launcher()
            .launchApp()
            .searchAccount(query: "Retirement Account")
            .assertAccountIsDisplayed(name: "Retirement Account", accountNumber: "***************6944")
    }
    
    func testEmptySearchResultIsDisplayed() {
        Launcher()
            .launchApp()
            .searchAccount(query: "Weird Name")
            .assertNoResultsDisplayed()
    }
    
    func testNoInternetErrorIsDisplayedInTheList() {
        Launcher()
            .launchApp(["hasError": "nilHTTPResponse"])
            .assertNoInternetMessageDisplayed()
    }
    
    func testPullToRefreshAccountsDisplayed() {
        Launcher()
            .launchApp()
            .pullToRefresh()
            .assertAccountScreenIsDisplayed()
    }
}
