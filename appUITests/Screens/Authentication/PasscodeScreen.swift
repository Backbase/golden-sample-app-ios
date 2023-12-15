//
//  UIConstants.swift
//  GoldenSampleUITests
//
//  Created by Backbase on 15/12/2023.
//

import Foundation

class PasscodeScreen : BaseScreen {
    
    //MARK: METHODS - ACTION
    func tapKey(_ keyToPress: String) {
        app.keys[keyToPress].tap()
    }
    
    func enterPasscode(_ passcode: String) {
        app.keyboards.firstMatch.waitForElementToAppear()
        passcode.map { String($0) }.forEach { tapKey($0) }
    }
    
}
