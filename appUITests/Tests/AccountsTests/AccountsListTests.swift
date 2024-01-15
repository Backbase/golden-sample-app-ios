//
//  AccountsListTests.swift
//  ios-golden-sample-app
//
//  Created by Ganjar Manggala on 15/12/2023.
//

import Foundation
import XCTest

final class AccountsListTests : BaseTestCase {
        
    let testData = AccountsListTestData.self
    
    override func setUp() {
        super.setUp()
        LoginScreen(app).authenticateUserWith(name: UserEnrollment.userName, password: UserEnrollment.password)
        WorkspacesSelectorScreen(app).selectServiceAgreementIfNeeded(workspaceName: UserEnrollment.boryCoffeeQA)
    }
    
    func testAccountIsDisplayedInTheList() {
        let accountListScreen = AccountsListScreen(app)
        
        accountListScreen.assertAccountScreenIsDisplayed()
        accountListScreen.assertAccountIsDisplayed(name: testData.defaultAccountName, accountNumberEndsWith: testData.defaultAccountNumberEnds, balance: testData.defaultBalance)
    }
    
    func testEmptySearchResultIsDisplayed() {
        let accountListScreen = AccountsListScreen(app)

        accountListScreen.searchAccount(query: testData.defaultAccountNumberEnds)
        accountListScreen.assertAccountIsDisplayed(name: testData.defaultAccountName, accountNumberEndsWith: testData.defaultAccountNumberEnds, balance: testData.defaultBalance)
    }
}
