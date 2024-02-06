//
//  AccountsListTests.swift
//  GoldenSampleUITests
//
//  Created by Backbase on 15/12/2023.
//

import Foundation
import XCTest

final class AccountsListTests: BaseTestCase {
        
    private let testData = AccountsListTestData.self
    
    override func setUp() {
        super.setUp()
        LoginScreen().authenticateUserWith(name: UserEnrollment.userName, password: UserEnrollment.password)
        WorkspacesSelectorScreen().selectServiceAgreementIfNeeded(workspaceName: UserEnrollment.boryCoffeeQA)
    }
    
    func testAccountIsDisplayedInTheList() {
        AccountsListScreen()
            .assertAccountScreenIsDisplayed()
            .assertAccountIsDisplayed(name: testData.defaultAccountName, accountNumberEndsWith: testData.defaultAccountNumberEnds)
    }
    
    func testEmptySearchResultIsDisplayed() {
        AccountsListScreen()
            .searchAccount(query: testData.defaultAccountNumberEnds)
            .assertAccountIsDisplayed(name: testData.defaultAccountName, accountNumberEndsWith: testData.defaultAccountNumberEnds)
    }
}
