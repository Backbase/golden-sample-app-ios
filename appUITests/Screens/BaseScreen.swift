//
//  UIConstants.swift
//  GoldenSampleUITests
//
//  Created by Backbase on 15/12/2023.
//

import Foundation
import XCTest

class BaseScreen {
    
    //MARK: ELEMENTS
    var app = XCUIApplication()
    
    lazy var navigationBar       = app.navigationBars.firstMatch
    lazy var navigationBarBtn = navigationBar.buttons.firstMatch
    lazy var navigationBarTitleLbl  = navigationBar.otherElements.firstMatch

    init(_ app: XCUIApplication) {
        self.app = app
    }
    
    //MARK: METHODS - ACTION
    func tapBack() {
        navigationBar.tap()
    }

    //MARK: METHODS - ASSERTION
    func assertTitleIsDisplayed(contains title: String, timeout: TimeInterval = Timeouts.defaultTimeout) {
        XCTAssert(navigationBar.exists)
        XCTAssert(navigationBarTitleLbl.exists)
    }
    
    //MARK: Other Method
    func expect(element: XCUIElement, status: UIStatus = .hittable, timeout: TimeInterval = Timeouts.defaultTimeout, message: String? = nil) -> XCUIElement {
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: status.rawValue), object: element)
        let result = XCTWaiter.wait(for: [expectation], timeout: timeout)
        if result == .timedOut {
            XCTFail(message ?? expectation.description)
        }
        return element
    }
}
