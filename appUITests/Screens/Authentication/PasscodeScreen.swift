//
//  UIConstants.swift
//  GoldenSampleUITests
//
//  Created by Backbase on 15/12/2023.
//

import Foundation

final class PasscodeScreen: BaseScreen {
    
    // MARK: METHODS - ACTION
    @discardableResult
    func tapKey(_ keyToPress: String) -> Self {
        app.keys[keyToPress].tap()
        return self
    }
    
    @discardableResult
    func enterPasscode(_ passcode: String, file: StaticString = #file, line: UInt = #line) -> Self {
        expect(element: app.keyboards.firstMatch, status: .hittable, file: file, line: line)
        passcode.map { String($0) }.forEach { tapKey($0) }
        return self
    }
}
