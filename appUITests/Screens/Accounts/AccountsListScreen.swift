//
//  AccountsListScreen.swift
//  GoldenSampleUITests
//
//  Created by Backbase on 15/12/2023.
//

import Foundation
import XCTest

final class AccountsListScreen: BaseScreen {
    
    private enum Identifier {
            static let myAccountsHeaderLabelId = "My Accounts"
        }

    // MARK: ELEMENTS
    private lazy var myAccountsHeaderLabel = app.staticTexts[Identifier.myAccountsHeaderLabelId]
    private lazy var searchAccountTextfield = app.searchFields.firstMatch
    private lazy var accountListTable = app.tables.firstMatch
    private var predicate: (String) -> NSPredicate = { query in
        NSPredicate(format: "label  CONTAINS %@", query)
    }
    
    // MARK: METHODS - ACTION
    @discardableResult
    func searchAccount(query: String) -> Self {
        expect(element: accountListTable, status: .hittable)
        searchAccountTextfield.tap()
        searchAccountTextfield.typeText(query)
        return self
    }
    
    // MARK: METHODS - ASSERTION
    @discardableResult
    func assertAccountScreenIsDisplayed(file: StaticString = #file, line: UInt = #line) -> Self {
        expect(element: accountListTable, status: .hittable, file: file, line: line)
        expect(element: myAccountsHeaderLabel, status: .exist, file: file, line: line)
        expect(element: searchAccountTextfield, status: .exist, file: file, line: line)
        expect(element: accountListTable, status: .exist, file: file, line: line)
        return self
    }
    
    @discardableResult
    func assertAccountIsDisplayed(name: String, accountNumber: String, balance: String? = nil, file: StaticString = #file, line: UInt = #line) -> Self {
        expect(element: accountListTable, status: .hittable)
        let labelName = app.staticTexts.containing(predicate(name)).firstMatch
        let labelAccountNumber = app.staticTexts[accountNumber].firstMatch
        expect(element: labelName, status: .exist, file: file, line: line)
        expect(element: labelAccountNumber, status: .exist, file: file, line: line)
        
        // Since test data comes from real live environment, balance is changing quickly thus i make it optional to avoid confusion in random test failure.
        if let balance {
            let lblBalance = app.staticTexts["$\(balance)"]
            expect(element: lblBalance, status: .exist)
        }
        return self
    }
    
    @discardableResult
    func assertNoResultsDisplayed(file: StaticString = #file, line: UInt = #line) -> Self {
        let noAccountsLabel = app.staticTexts.containing(predicate("No accounts")).firstMatch
        expect(element: noAccountsLabel, status: .exist, file: file, line: line)
        return self
    }
    
    @discardableResult
    func assertNoInternetMessageDisplayed(file: StaticString = #file, line: UInt = #line) -> Self {
        let notConnectedLabel = app.staticTexts.containing(predicate("Ohhh Shooot")).firstMatch
        let somethingWentWrongLabel = app.staticTexts.containing(predicate("Something wrong happened")).firstMatch
        expect(element: notConnectedLabel, status: .exist, file: file, line: line)
        expect(element: somethingWentWrongLabel, status: .exist, file: file, line: line)
        return self
    }
    
    @discardableResult
    func pullToRefresh() -> Self {
        pullToRefreshElement(element: accountListTable)
        return self
    }
    
    // Helpers
    @discardableResult
    func pullToRefreshElement(element: XCUIElement) -> Self {
        XCTAssertTrue(element.waitForExistence(timeout: 2))
        let start = element.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let finish = element.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 100))
        start.press(forDuration: 0, thenDragTo: finish)
        XCTAssertTrue(element.waitForExistence(timeout: 20))
        if !element.visible(app) {
            XCTFail("Could not pull to refresh")
        }
        return self
    }
}

extension XCUIElement {
    func visible(_ app: XCUIApplication) -> Bool {
        guard self.exists && !self.frame.isEmpty else { return false }
        return app.windows.element(boundBy: 0).frame.contains(self.frame)
    }
}
