//
//  AccountsListTests.swift
//  GoldenSampleUITests
//
//  Created by Backbase on 15/12/2023.
//

import Foundation
import XCTest

final class AccountsListTests: BaseTestCase {
    
    // Before running UI Tests, please adjust your testing account and test data accordingly.
        
    private let testData = AccountsListTestData.self
    
    override func setUp() {
        super.setUp()
        LoginScreen().authenticateUserWith(name: UserEnrollment.userName, password: UserEnrollment.password)
        WorkspacesSelectorScreen().selectServiceAgreementIfNeeded(workspaceName: UserEnrollment.defaultWorkspace)
    }
    
    func testAccountIsDisplayedInTheList() {
        AccountsListScreen()
            .assertAccountScreenIsDisplayed()
            .assertAccountIsDisplayed(name: testData.defaultAccountName, accountNumber: testData.defaultAccountNumber)
    }
    
    func testEmptySearchResultIsDisplayed() {
        AccountsListScreen()
            .searchAccount(query: testData.defaultAccountName)
            .assertAccountIsDisplayed(name: testData.defaultAccountName, accountNumber: testData.defaultAccountNumber)
    }
}
