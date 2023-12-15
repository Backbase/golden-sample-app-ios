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
    lazy var navigationBarButton = navigationBar.buttons.firstMatch
    lazy var navigationBarTitle  = navigationBar.otherElements.firstMatch

    init(_ app: XCUIApplication) {
        self.app = app
    }
    
    //MARK: METHODS - ACTION
    func tapBack() {
        navigationBar.tap()
    }

    //MARK: METHODS - ASSERTION
    func checkTitle(contains title: String, timeout: TimeInterval = Timeouts.defaultTimeout) {
        XCTAssert(navigationBar.exists)
        XCTAssert(navigationBarTitle.exists)
    }
}
