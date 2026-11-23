//
//  AccountsListScreen.swift
//  GoldenSampleUITests
//
//  Created by Backbase on 15/12/2023.
//

import Foundation
import XCTest

/// Page object of the SwiftUI `AccountsListView`.
///
/// The list is a `ScrollView` (not a `UITableView`) and every row is a `Button` that exposes
/// the account name, number/state and balance both as its own label and as static texts.
final class AccountsListScreen: BaseScreen {
    
    private enum Identifier {
        static let myAccountsHeaderLabelId = "My Accounts"
        // Set by the SwiftUI `AccountsListView`.
        static let scrollViewId = "AccountsListScrollView"
        static let searchFieldId = "AccountsListSearchField"
        static let rowIdPrefix = "AccountsListRow_"
    }

    // MARK: ELEMENTS
    // The title appears in the tab selector more than once (and in an accessibility copy of it).
    private lazy var myAccountsHeaderLabel = app.staticTexts[Identifier.myAccountsHeaderLabelId].firstMatch
    private lazy var searchAccountTextfield = app.textFields[Identifier.searchFieldId]
    private lazy var accountList = app.scrollViews[Identifier.scrollViewId]
    /// Each row is a single button whose label combines the name, the number (or state) and the balance.
    private lazy var accountRows = app.buttons
        .matching(NSPredicate(format: "identifier BEGINSWITH %@", Identifier.rowIdPrefix))
    private var predicate: (String) -> NSPredicate = { query in
        NSPredicate(format: "label  CONTAINS %@", query)
    }
    
    // MARK: METHODS - ACTION
    /// Types the query into the search field.
    ///
    /// The field is only shown once the accounts are loaded, so the method waits until it can be tapped
    /// and types synchronously. The caller's next assertion therefore always runs after the typing.
    @discardableResult
    func searchAccount(query: String, file: StaticString = #file, line: UInt = #line) -> Self {
        expect(element: accountList, status: .hittable, file: file, line: line)
        expect(element: searchAccountTextfield, status: .hittable, file: file, line: line)
        searchAccountTextfield.tap()
        searchAccountTextfield.typeText(query)
        return self
    }
    
    @discardableResult
    func pullToRefresh(file: StaticString = #file, line: UInt = #line) -> Self {
        expect(element: accountList, status: .hittable, file: file, line: line)
        // Drag from the upper part of the list to its lower part, offsets are normalized to the element's frame.
        let start = accountList.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.1))
        let finish = accountList.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.8))
        start.press(forDuration: 0.1, thenDragTo: finish)
        return self
    }

    /// Taps the row of the account with the given name and returns the screen it opens.
    @discardableResult
    func tapAccount(named name: String, file: StaticString = #file, line: UInt = #line) -> AccountDetailsScreen {
        expect(element: accountList, status: .hittable, file: file, line: line)
        let row = accountRows.matching(predicate(name)).firstMatch
        expect(element: row, status: .hittable, file: file, line: line)
        row.tap()
        return AccountDetailsScreen(app)
    }
    
    // MARK: METHODS - ASSERTION
    @discardableResult
    func assertAccountScreenIsDisplayed(file: StaticString = #file, line: UInt = #line) -> Self {
        expect(element: accountList, status: .hittable, file: file, line: line)
        expect(element: myAccountsHeaderLabel, status: .exist, file: file, line: line)
        expect(element: searchAccountTextfield, status: .exist, file: file, line: line)
        expect(element: accountRows.firstMatch, status: .exist, file: file, line: line)
        return self
    }
    
    @discardableResult
    func assertAccountIsDisplayed(name: String, accountNumber: String, balance: String? = nil, file: StaticString = #file, line: UInt = #line) -> Self {
        expect(element: accountList, status: .hittable, file: file, line: line)
        let row = accountRows.matching(predicate(name)).firstMatch
        expect(element: row, status: .exist, file: file, line: line)
        XCTAssertTrue(row.label.contains(accountNumber), "Row \"\(row.label)\" does not contain \(accountNumber)", file: file, line: line)
        
        // Since test data comes from real live environment, balance is changing quickly thus i make it optional to avoid confusion in random test failure.
        if let balance {
            XCTAssertTrue(row.label.contains(balance), "Row \"\(row.label)\" does not contain \(balance)", file: file, line: line)
        }
        return self
    }

    /// Waits until no row of the list contains the given name, e.g. after the list got filtered.
    @discardableResult
    func assertAccountIsNotDisplayed(name: String, file: StaticString = #file, line: UInt = #line) -> Self {
        expect(element: accountRows.matching(predicate(name)).firstMatch, status: .notExist, file: file, line: line)
        return self
    }
    
    @discardableResult
    func assertNoResultsDisplayed(file: StaticString = #file, line: UInt = #line) -> Self {
        let noAccountsLabel = app.staticTexts.containing(predicate(AccountsListTestData.noAccountsLabel)).firstMatch
        expect(element: noAccountsLabel, status: .exist, file: file, line: line)
        XCTAssertEqual(accountRows.count, 0, "No account row is expected while the search has no results", file: file, line: line)
        return self
    }
    
    @discardableResult
    func assertNoInternetMessageDisplayed(file: StaticString = #file, line: UInt = #line) -> Self {
        let notConnectedLabel = app.staticTexts.containing(predicate(AccountsListTestData.ohhShootLabel)).firstMatch
        let somethingWentWrongLabel = app.staticTexts.containing(predicate(AccountsListTestData.somethingWentWrongLabel)).firstMatch
        expect(element: notConnectedLabel, status: .exist, file: file, line: line)
        expect(element: somethingWentWrongLabel, status: .exist, file: file, line: line)
        return self
    }
}

// MARK: - Account details

/// Page object of the SwiftUI `AccountDetailsView`.
///
/// The header and every row of a section are one accessibility element each (`.combine`), so their
/// label is "<title>, <subtitle>", e.g. "Account Type, Current Account".
final class AccountDetailsScreen: BaseScreen {

    private enum Identifier {
        // Set by the SwiftUI `AccountDetailsView`.
        static let scrollViewId = "AccountDetailsScrollView"
        static let stateViewId = "AccountDetailsStateView"
    }

    // MARK: ELEMENTS
    /// The navigation bar is identified by its title.
    private lazy var detailsNavigationBar = app.navigationBars[AccountDetailsTestData.screenTitle]
    private lazy var detailsList = app.scrollViews[Identifier.scrollViewId]
    private lazy var stateView = app.descendants(matching: .any)[Identifier.stateViewId].firstMatch

    // MARK: METHODS - ACTION
    @discardableResult
    func tapBackToAccountsList(file: StaticString = #file, line: UInt = #line) -> AccountsListScreen {
        let backButton = detailsNavigationBar.buttons.firstMatch
        expect(element: backButton, status: .hittable, file: file, line: line)
        backButton.tap()
        return AccountsListScreen(app)
    }

    // MARK: METHODS - ASSERTION
    @discardableResult
    func assertAccountDetailsIsDisplayed(file: StaticString = #file, line: UInt = #line) -> Self {
        expect(element: detailsNavigationBar, status: .exist, file: file, line: line)
        expect(element: detailsList, status: .exist, file: file, line: line)
        return self
    }

    /// The header shows the product name, the account number, the balance and the credit limit.
    @discardableResult
    func assertHeaderIsDisplayed(productKind: String, accountNumber: String, file: StaticString = #file, line: UInt = #line) -> Self {
        let predicate = NSPredicate(
            format: "label BEGINSWITH %@ AND label CONTAINS %@ AND label CONTAINS %@",
            productKind, accountNumber, AccountDetailsTestData.limitTitle
        )
        expect(element: detailsList.staticTexts.matching(predicate).firstMatch, status: .exist, file: file, line: line)
        return self
    }

    @discardableResult
    func assertSectionTitleIsDisplayed(_ title: String, file: StaticString = #file, line: UInt = #line) -> Self {
        // The design shows section titles in capitals.
        expect(element: detailsList.staticTexts[title.uppercased()], status: .exist, file: file, line: line)
        return self
    }

    @discardableResult
    func assertRowIsDisplayed(title: String, value: String, file: StaticString = #file, line: UInt = #line) -> Self {
        let predicate = NSPredicate(format: "label BEGINSWITH %@ AND label ENDSWITH %@", title, value)
        expect(element: detailsList.staticTexts.matching(predicate).firstMatch, status: .exist, file: file, line: line)
        return self
    }

    @discardableResult
    func assertErrorIsNotDisplayed(file: StaticString = #file, line: UInt = #line) -> Self {
        expect(element: stateView, status: .notExist, timeout: Timeouts.shorterTimeout, file: file, line: line)
        return self
    }
}
