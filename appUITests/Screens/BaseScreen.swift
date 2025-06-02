//
//  UIConstants.swift
//  GoldenSampleUITests
//
//  Created by Backbase on 15/12/2023.
//

import Foundation
import XCTest

class BaseScreen {
    
    // MARK: ELEMENTS
    internal let app: XCUIApplication
    
    lazy var navigationBar = app.navigationBars.firstMatch
    lazy var navigationBarBtn = navigationBar.buttons.firstMatch
    lazy var navigationBarTitleLbl = navigationBar.otherElements.firstMatch

    init() {
        self.app = XCUIApplication()
    }
    
    // MARK: METHODS - ACTION
    @discardableResult
    func tapBack() -> Self {
        navigationBar.tap()
        return self
    }

    // MARK: METHODS - ASSERTION
    @discardableResult
    func assertTitleIsDisplayed(contains title: String, timeout: TimeInterval = Timeouts.defaultTimeout) -> Self {
        expect(element: navigationBar, status: .exist)
        expect(element: navigationBarTitleLbl, status: .exist)
        return self
    }
    
    // MARK: Other Method
    @discardableResult
    func expect(element: XCUIElement, status: UIStatus = .hittable, timeout: TimeInterval = Timeouts.defaultTimeout, message: String? = nil, file: StaticString = #file, line: UInt = #line) -> XCUIElement {
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: status.rawValue), object: element)
        let result = XCTWaiter.wait(for: [expectation], timeout: timeout)
        if result == .timedOut {
            XCTFail(message ?? expectation.description, file: file, line: line)
        }
        return element
    }
}
