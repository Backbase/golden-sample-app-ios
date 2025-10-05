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
    private(set) var app: XCUIApplication
    
    private lazy var navigationBar = app.navigationBars.firstMatch
    private lazy var navigationBarButton = navigationBar.buttons.firstMatch
    private lazy var navigationBarTitleLabel = navigationBar.otherElements.firstMatch
    
    init(_ app: XCUIApplication = XCUIApplication()) {
        self.app = app
    }
    
    func start(timeout: TimeInterval = Timeouts.defaultTimeout) -> Self {
        app.launch()
        app.expect(status: .exist, timeout: Timeouts.defaultTimeout)
        return self
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
        expect(element: navigationBarTitleLabel, status: .exist)
        return self
    }
    
    // MARK: Other Method
    // swiftlint:disable line_length
    @discardableResult
    func expect(element: XCUIElement, status: UIStatus = .hittable, timeout: TimeInterval = Timeouts.defaultTimeout, message: String? = nil, file: StaticString = #file, line: UInt = #line) -> XCUIElement {
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: status.rawValue), object: element)
        let result = XCTWaiter.wait(for: [expectation], timeout: timeout)
        if result == .timedOut {
            XCTFail(message ?? expectation.description, file: file, line: line)
        }
        return element
    }
    // swiftlint:enable line_length
}
