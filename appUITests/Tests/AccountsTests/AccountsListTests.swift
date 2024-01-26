//
//  AccountsListTests.swift
//  GoldenSampleUITests
//
//  Created by Backbase on 15/12/2023.
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
        AccountsListScreen(app)
            .assertAccountScreenIsDisplayed()
            .assertAccountIsDisplayed(name: testData.defaultAccountName, accountNumberEndsWith: testData.defaultAccountNumberEnds)
    }
    
    func testEmptySearchResultIsDisplayed() {
        AccountsListScreen(app)
            .searchAccount(query: testData.defaultAccountNumberEnds)
            .assertAccountIsDisplayed(name: testData.defaultAccountName, accountNumberEndsWith: testData.defaultAccountNumberEnds)
    }
}
