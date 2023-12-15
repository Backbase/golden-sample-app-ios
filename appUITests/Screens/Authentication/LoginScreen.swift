//
//  UIConstants.swift
//  GoldenSampleUITests
//
//  Created by Backbase on 15/12/2023.
//

import Foundation
import XCTest

class LoginScreen : BaseScreen {
    
    //MARK: ELEMENTS
    private lazy var titleLabel = app.staticTexts.matching(identifier: "register.titleLabel").firstMatch
    private lazy var btnLogin = app.buttons.matching(identifier: "register.loginButton").firstMatch
    private lazy var tfUsername = app.textFields.matching(identifier: "register.usernameInput.textInput.textField").firstMatch
    private lazy var tfPassword = app.secureTextFields.matching(identifier: "register.passwordInput.textInput.textField").firstMatch
    private lazy var allowButton = app.buttons.matching(identifier: "biometricRegistration.allowButton").firstMatch
    private lazy var denyButton = app.buttons.matching(identifier: "biometricRegistration.denyButton").firstMatch
    private lazy var passcodeButton = app.buttons.matching(identifier: "login.passcodeButton").firstMatch

    private lazy var passcodeScreen = PasscodeScreen(app)
    private lazy var successAuthScreen = SetupCompleteScreen(app)
    
    //MARK: METHODS - ACTION
    func denyBiometricUsage() {
        if (denyButton.waitForElementToAppear() && denyButton.isHittable) {
            denyButton.tap()
        }
    }
    
    func taploginWithPasscodeButton() {
        if passcodeButton.isHittable {
            passcodeButton.tap()
        }
    }

    func login(withUsername username: String, password: String) {
        tfUsername.tap()
        tfUsername.typeText(username)
        tfPassword.tap()
        tfPassword.typeText(password)
        btnLogin.tap()
    }
    
    func authenticateUserWith(name: String, password: String) {
        titleLabel.waitForElementToAppear(timeout: Timeouts.defaultTimeout)

        if titleLabel.exists {
            login(withUsername: name, password: password)
            denyBiometricUsage()
            passcodeScreen.enterPasscode(UserEnrollment.validPasscode)
            passcodeScreen.enterPasscode(UserEnrollment.validPasscode)
            successAuthScreen.dismissLetsGetStartedScreen()
        } else {
            taploginWithPasscodeButton()
            passcodeScreen.enterPasscode(UserEnrollment.validPasscode)
        }
    }
}
