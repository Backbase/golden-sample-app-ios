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
    func waitForElementToAppear(timeout: TimeInterval = Timeouts.defaultTimeout) -> Bool {
        waitForExistence(timeout: timeout)
    }
}
