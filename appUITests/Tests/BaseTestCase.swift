//
//  BaseTestCase.swift
//  GoldenSampleUITests
//
//  Created by Ganjar Manggala on 15/12/2023.
//

import XCTest

class BaseTestCase: XCTestCase {
    
    //MARK: ELEMENTS
    var app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }

}
