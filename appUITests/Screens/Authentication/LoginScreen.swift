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
    private lazy var titleLbl = app.staticTexts.matching(identifier: "register.titleLabel").firstMatch
    private lazy var loginBtn = app.buttons.matching(identifier: "register.loginButton").firstMatch
    private lazy var usernameTf = app.textFields.matching(identifier: "register.usernameInput.textInput.textField").firstMatch
    private lazy var passwordTf = app.secureTextFields.matching(identifier: "register.passwordInput.textInput.textField").firstMatch
    private lazy var allowBtn = app.buttons.matching(identifier: "biometricRegistration.allowButton").firstMatch
    private lazy var denyBtn = app.buttons.matching(identifier: "biometricRegistration.denyButton").firstMatch
    private lazy var passcodeBtn = app.buttons.matching(identifier: "login.passcodeButton").firstMatch

    private lazy var passcodeScreen = PasscodeScreen(app)
    private lazy var successAuthScreen = SetupCompleteScreen(app)
    
    //MARK: METHODS - ACTION
    func denyBiometricUsage() {
        expect(element: denyBtn, status: .hittable, timeout: Timeouts.defaultTimeout).tap()
    }
    
    func taploginWithPasscodeButton() {
        expect(element: passcodeBtn, status: .hittable, timeout: Timeouts.defaultTimeout).tap()
    }

    func login(withUsername username: String, password: String) {
        expect(element: usernameTf, status: .hittable, timeout: Timeouts.defaultTimeout).tap()
        usernameTf.typeText(username)
        passwordTf.tap()
        passwordTf.typeText(password)
        loginBtn.tap()
    }
    
    func authenticateUserWith(name: String, password: String) {
        
        if titleLbl.exists {
            login(withUsername: name, password: password)
            denyBiometricUsage()
            passcodeScreen.enterPasscode(UserEnrollment.validPasscode)
            passcodeScreen.enterPasscode(UserEnrollment.validPasscode)
            successAuthScreen.dismissLetsGetStartedScreen()
        } else {
            passcodeScreen.enterPasscode(UserEnrollment.validPasscode)
        }
    }
}
