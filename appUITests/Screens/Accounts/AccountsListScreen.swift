//
//  AccountsListScreen.swift
//  GoldenSampleUITests
//
//  Created by Backbase on 15/12/2023.
//

import Foundation
import XCTest

class AccountsListScreen : BaseScreen {

    //MARK: ELEMENTS
    private lazy var myAccountsHeaderLbl = app.staticTexts["My Accounts"]
    private lazy var searchAccountTf = app.searchFields.firstMatch
    private lazy var accountListTbl = app.tables.firstMatch
    private var predicate: (String) -> NSPredicate = { query in
        NSPredicate(format: "label  CONTAINS %@", query)
    }
    
    //MARK: METHODS - ACTION
    func searchAccount(query: String) {
        expect(element: accountListTbl, status: .hittable, timeout: Timeouts.defaultTimeout)
        searchAccountTf.tap()
        searchAccountTf.typeText(query)
    }
    
    //MARK: METHODS - ASSERTION
    func assertAccountScreenIsDisplayed() {
        expect(element: accountListTbl, status: .hittable, timeout: Timeouts.defaultTimeout)
        XCTAssert(myAccountsHeaderLbl.exists)
        XCTAssert(searchAccountTf.exists)
        XCTAssert(accountListTbl.exists)
    }
    
    func assertAccountIsDisplayed(name: String, accountNumberEndsWith: String, balance: String) {
        expect(element: accountListTbl, status: .hittable, timeout: Timeouts.defaultTimeout)
        let lblName = app.staticTexts.containing(predicate(name)).firstMatch
        let lblAccountNumber = app.staticTexts["************\(accountNumberEndsWith)"].firstMatch
        let lblBalance = app.staticTexts["$\(balance)"]
        
        XCTAssert(lblName.exists)
        XCTAssert(lblAccountNumber.exists)
        XCTAssert(lblBalance.exists)
    }
}
