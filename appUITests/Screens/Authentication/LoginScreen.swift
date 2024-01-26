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
    
    //MARK: METHODS - ACTION
    @discardableResult
    func denyBiometricUsage() -> Self {
        expect(element: denyBtn, status: .hittable).tap()
        return self
    }
    
    @discardableResult
    func taploginWithPasscodeButton() -> Self {
        expect(element: passcodeBtn, status: .hittable).tap()
        return self
    }

    @discardableResult
    func login(withUsername username: String, password: String) -> Self {
        expect(element: usernameTf, status: .hittable).tap()
        usernameTf.typeText(username)
        passwordTf.tap()
        passwordTf.typeText(password)
        loginBtn.tap()
        return self
    }
    
    @discardableResult
    func authenticateUserWith(name: String, password: String) -> Self {
        
        if titleLbl.exists {
            login(withUsername: name, password: password)
            denyBiometricUsage()
            passcodeScreen
                .enterPasscode(UserEnrollment.validPasscode)
                .enterPasscode(UserEnrollment.validPasscode)
            SetupCompleteScreen(app).dismissLetsGetStartedScreen()
        } else {
            passcodeScreen.enterPasscode(UserEnrollment.validPasscode)
        }
        return self
    }
}
