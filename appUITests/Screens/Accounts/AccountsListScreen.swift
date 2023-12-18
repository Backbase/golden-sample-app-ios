//
//  AccountsListScreen.swift
//  GoldenSampleUITests
//
//  Created by Ganjar Manggala on 15/12/2023.
//

import Foundation
import XCTest

class AccountsListScreen : BaseScreen {

    //MARK: ELEMENTS
    private lazy var lblMyaccountsHeader = app.staticTexts["My Accounts"]
    private lazy var tfSearchAccount = app.searchFields.firstMatch
    private lazy var tblAccountList = app.tables.firstMatch
    private var predicate: (String) -> NSPredicate = { query in
        NSPredicate(format: "label  CONTAINS %@", query)
    }
    
    //MARK: METHODS - ACTION
    func searchAccount(query: String) {
        tfSearchAccount.tap()
        tfSearchAccount.typeText(query)
        tblAccountList.waitForElementToAppear()
    }
    
    //MARK: METHODS - ASSERTION
    func validateAccountScreenIsDisplayed() {
        tblAccountList.waitForElementToAppear()
        XCTAssert(lblMyaccountsHeader.exists)
        XCTAssert(tfSearchAccount.exists)
        XCTAssert(tblAccountList.exists)
    }
    
    func assertAccountIsDisplayed(name: String, accountNumberEndsWith: String, balance: String) {
        let lblName = app.staticTexts.containing(predicate(name)).firstMatch
        let lblAccountNumber = app.staticTexts["************\(accountNumberEndsWith)"].firstMatch
        let lblBalance = app.staticTexts["$\(balance)"]
        
        XCTAssert(lblName.exists)
        XCTAssert(lblAccountNumber.exists)
        XCTAssert(lblBalance.exists)
    }
}
