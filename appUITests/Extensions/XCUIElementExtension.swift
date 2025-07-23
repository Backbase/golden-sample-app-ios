//
//  UIConstants.swift
//  GoldenSampleUITests
//
//  Created by Backbase on 15/12/2023.
//

import Foundation
import XCTest

extension XCUIElement {
    
    /// Wait for an element exist until it gets timeout. if the element exist before timeout, the process will continue immediately
    /// - Parameter timeout preferred amount of time for waiting
    /// - Returns: BOOL whether the element exist or not
    @discardableResult
    func waitForElementToAppear(timeout: TimeInterval = Timeouts.defaultTimeout) -> Bool {
        waitForExistence(timeout: timeout)
    }
    
    @discardableResult
    func expect(status: UIStatus, timeout: TimeInterval = Timeouts.defaultTimeout, message: String? = nil, file: StaticString = #filePath, line: UInt = #line) -> XCUIElement {
        let isElementFound = self.waitForExistence(timeout: timeout)
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: status.rawValue), object: self)
        let result = XCTWaiter.wait(for: [expectation], timeout: timeout)
        if result == .timedOut || !isElementFound {
            XCTAssert(false, message ?? expectation.description, file: file, line: line)
        }
        return self
    }
}
