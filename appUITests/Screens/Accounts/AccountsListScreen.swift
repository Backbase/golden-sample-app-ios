//
//  AccountsListScreen.swift
//  GoldenSampleUITests
//
//  Created by Backbase on 15/12/2023.
//

import Foundation
import XCTest

final class AccountsListScreen : BaseScreen {
    
    private enum Identifier {
            static let myAccountsHeaderLblId = "My Accounts"
        }

    //MARK: ELEMENTS
    private lazy var myAccountsHeaderLbl = app.staticTexts[Identifier.myAccountsHeaderLblId]
    private lazy var searchAccountTf = app.searchFields.firstMatch
    private lazy var accountListTbl = app.tables.firstMatch
    private var predicate: (String) -> NSPredicate = { query in
        NSPredicate(format: "label  CONTAINS %@", query)
    }
    
    //MARK: METHODS - ACTION
    @discardableResult
    func searchAccount(query: String) -> Self {
        expect(element: accountListTbl, status: .hittable)
        searchAccountTf.tap()
        searchAccountTf.typeText(query)
        return self
    }
    
    //MARK: METHODS - ASSERTION
    
    @discardableResult
    func assertAccountScreenIsDisplayed() -> Self {
        expect(element: accountListTbl, status: .hittable)
        expect(element: myAccountsHeaderLbl, status: .exist)
        expect(element: searchAccountTf, status: .exist)
        expect(element: accountListTbl, status: .exist)
        return self
    }
    
    @discardableResult
    func assertAccountIsDisplayed(name: String, accountNumberEndsWith: String, balance: String? = nil) -> Self {
        expect(element: accountListTbl, status: .hittable)
        let lblName = app.staticTexts.containing(predicate(name)).firstMatch
        let lblAccountNumber = app.staticTexts["************\(accountNumberEndsWith)"].firstMatch
        expect(element: lblName, status: .exist)
        expect(element: lblAccountNumber, status: .exist)
        
        //Since test data comes from real live environment, balance is changing quickly thus i make it optional to avoid confusion in random test failure.
        if let balance {
            let lblBalance = app.staticTexts["$\(balance)"]
            expect(element: lblBalance, status: .exist)
        }
        return self
    }
}
