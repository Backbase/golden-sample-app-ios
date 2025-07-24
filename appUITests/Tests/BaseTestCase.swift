//
//  BaseTestCase.swift
//  GoldenSampleUITests
//
//  Created by Backbase on 15/12/2023.
//

import XCTest

class BaseTestCase: XCTestCase {
    
    // MARK: ELEMENTS
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        self.continueAfterFailure = false
        app = XCUIApplication()
        prepare(app)
    }
    
    override func tearDown() {
        super.tearDown()
        XCUIApplication().terminate()
    }
    
    func prepare(_ app: XCUIApplication) {
        app.launchArguments += ["UITests"]
        app.launch()
        
        LoginScreen()
            .authenticateUserWith(
                name: UserEnrollment.userName,
                password: UserEnrollment.password
            )
    }
}
