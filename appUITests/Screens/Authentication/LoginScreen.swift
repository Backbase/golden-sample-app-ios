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
            static let loginButtonId = "register.loginButton"
            static let usernameTextfieldId = "register.usernameInput.textInput.textField"
            static let passwordTextfieldId = "register.passwordInput.textInput.textField"
            static let allowButtonId = "biometricRegistration.allowButton"
            static let denyButtonId = "biometricRegistration.denyButton"
            static let passcodeButtonId = "login.passcodeButton"
    }
    
    // MARK: ELEMENTS
    private lazy var titleLabel = app.staticTexts.matching(identifier: Identifier.titleLabelId).firstMatch
    private lazy var loginButton = app.buttons.matching(identifier: Identifier.loginButtonId).firstMatch
    private lazy var usernameTextfield = app.textFields.matching(identifier: Identifier.usernameTextfieldId).firstMatch
    private lazy var passwordTextfield = app.secureTextFields.matching(identifier: Identifier.passwordTextfieldId).firstMatch
    private lazy var allowButton = app.buttons.matching(identifier: Identifier.allowButtonId).firstMatch
    private lazy var denyButton = app.buttons.matching(identifier: Identifier.denyButtonId).firstMatch
    private lazy var passcodeButton = app.buttons.matching(identifier: Identifier.passcodeButtonId).firstMatch

    private lazy var passcodeScreen = PasscodeScreen()
    
    // MARK: METHODS - ACTION
    @discardableResult
    func denyBiometricUsage() -> Self {
        expect(element: denyButton, status: .hittable).tap()
        return self
    }
    
    @discardableResult
    func taploginWithPasscodeButton() -> Self {
        expect(element: passcodeButton, status: .hittable).tap()
        return self
    }

    @discardableResult
    func login(withUsername username: String, password: String) -> Self {
        expect(element: usernameTextfield, status: .hittable).tap()
        usernameTextfield.typeText(username)
        passwordTextfield.tap()
        passwordTextfield.typeText(password)
        loginButton.tap()
        return self
    }
    
    @discardableResult
    func authenticateUserWith(name: String, password: String, file: StaticString = #file, line: UInt = #line) -> Self {
        if titleLabel.exists {
            login(withUsername: name, password: password)
            denyBiometricUsage()
            passcodeScreen
                .enterPasscode(UserEnrollment.validPasscode, file: file, line: line)
                .enterPasscode(UserEnrollment.validPasscode, file: file, line: line)
            SuccessAuthScreen().dismissLetsGetStartedScreen()
        } else {
            passcodeScreen.enterPasscode(UserEnrollment.validPasscode, file: file, line: line)
        }
        return self
    }
}
