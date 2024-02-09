//
//  UIConstants.swift
//  GoldenSampleUITests
//
//  Created by Backbase on 15/12/2023.
//

import Foundation
import XCTest

final class LoginScreen: BaseScreen {
    
    private enum Identifier {
            static let titleLabelId = "register.titleLabel"
            static let loginBtnId = "register.loginButton"
            static let usernameTfId = "register.usernameInput.textInput.textField"
            static let passwordTfId = "register.passwordInput.textInput.textField"
            static let allowBtnId = "biometricRegistration.allowButton"
            static let denyBtnId = "biometricRegistration.denyButton"
            static let passcodeBtnId = "login.passcodeButton"
        }
    
    // MARK: ELEMENTS
    private lazy var titleLbl = app.staticTexts.matching(identifier: Identifier.titleLabelId).firstMatch
    private lazy var loginBtn = app.buttons.matching(identifier: Identifier.loginBtnId).firstMatch
    private lazy var usernameTf = app.textFields.matching(identifier: Identifier.usernameTfId).firstMatch
    private lazy var passwordTf = app.secureTextFields.matching(identifier: Identifier.passwordTfId).firstMatch
    private lazy var allowBtn = app.buttons.matching(identifier: Identifier.allowBtnId).firstMatch
    private lazy var denyBtn = app.buttons.matching(identifier: Identifier.denyBtnId).firstMatch
    private lazy var passcodeBtn = app.buttons.matching(identifier: Identifier.passcodeBtnId).firstMatch

    private lazy var passcodeScreen = PasscodeScreen()
    
    // MARK: METHODS - ACTION
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
            SuccessAuthScreen().dismissLetsGetStartedScreen()
        } else {
            passcodeScreen.enterPasscode(UserEnrollment.validPasscode)
        }
        return self
    }
}
