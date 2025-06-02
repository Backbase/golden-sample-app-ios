//
//  LoginScreen.swift
//  GoldenSampleUITests
//
//  Created by Backbase on 15/12/2023.
//

import Foundation
import XCTest

final class LoginScreen: BaseScreen {
    
    private enum Identifier {
            static let titleLabelIdentifier = "register.titleLabel"
            static let loginButtonIdentifier = "register.loginButton"
            static let usernameTextFieldIdentifier = "register.usernameInput.textInput.textField"
            static let passwordTextfieldIdentifier = "register.passwordInput.textInput.textField"
            static let allowButtonIdentifier = "biometricRegistration.allowButton"
            static let denyButtonIdentifier = "biometricRegistration.denyButton"
            static let passcodeButtonIdentifier = "login.passcodeButton"
    }
    
    // MARK: ELEMENTS
    private lazy var titleLabel = app.staticTexts.matching(identifier: Identifier.titleLabelIdentifier).firstMatch
    private lazy var loginButton = app.buttons.matching(identifier: Identifier.loginButtonIdentifier).firstMatch
    private lazy var usernameTextField = app.textFields.matching(identifier: Identifier.usernameTextFieldIdentifier).firstMatch
    private lazy var passwordTextField = app.secureTextFields.matching(identifier: Identifier.passwordTextfieldIdentifier).firstMatch
    private lazy var allowButton = app.buttons.matching(identifier: Identifier.allowButtonIdentifier).firstMatch
    private lazy var denyButton = app.buttons.matching(identifier: Identifier.denyButtonIdentifier).firstMatch
    private lazy var passcodeButton = app.buttons.matching(identifier: Identifier.passcodeButtonIdentifier).firstMatch

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
        expect(element: usernameTextField, status: .hittable).tap()
        usernameTextField.typeText(username)
        passwordTextField.tap()
        passwordTextField.typeText(password)
        loginButton.tap()
        return self
    }
    
    @discardableResult
    func authenticateUserWith(name: String, password: String) -> Self {
        if titleLabel.exists {
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
