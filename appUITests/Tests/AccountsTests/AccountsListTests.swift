//
//  AccountsListTests.swift
//  ios-golden-sample-app
//
//  Created by Ganjar Manggala on 15/12/2023.
//

import Foundation
import XCTest

final class AccountsListTests : BaseTestCase {
        
    override func setUp() {
        super.setUp()
        LoginScreen(app).authenticateUserWith(name: UserEnrollment.userName, password: UserEnrollment.password)
        WorkspacesSelectorScreen(app).selectServiceAgreementIfNeeded(workspaceName: UserEnrollment.boryCoffeeQA)
    }
    
    func testAccountIsDisplayedInTheList() {
        let accountListScreen = AccountsListScreen(app)
        
        accountListScreen.validateAccountScreenIsDisplayed()
        accountListScreen.assertAccountIsDisplayed(name: "Checking Account USD 7299", accountNumberEndsWith: "7299", balance: "11,284.38")
    }
    
    func testEmptySearchResultIsDisplayed() {
        let accountListScreen = AccountsListScreen(app)

        accountListScreen.searchAccount(query: "7299")
        accountListScreen.assertAccountIsDisplayed(name: "Checking Account USD 7299", accountNumberEndsWith: "7299", balance: "11,284.38")
    }
}
