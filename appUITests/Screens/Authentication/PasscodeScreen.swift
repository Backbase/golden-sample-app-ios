//
//  UIConstants.swift
//  GoldenSampleUITests
//
//  Created by Backbase on 15/12/2023.
//

import Foundation

class PasscodeScreen : BaseScreen {
    
    //MARK: METHODS - ACTION
    @discardableResult
    func tapKey(_ keyToPress: String) -> Self {
        app.keys[keyToPress].tap()
        return self
    }
    
    @discardableResult
    func enterPasscode(_ passcode: String) -> Self {
        expect(element: app.keyboards.firstMatch, status: .hittable)
        passcode.map { String($0) }.forEach { tapKey($0) }
        return self
    }
    
}
