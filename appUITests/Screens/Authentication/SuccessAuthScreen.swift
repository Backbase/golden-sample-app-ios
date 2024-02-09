//
//  UIConstants.swift
//  GoldenSampleUITests
//
//  Created by Backbase on 15/12/2023.
//

import Foundation

final class SuccessAuthScreen: BaseScreen {
    
    private enum Identifier {
        static let letsGetStartedBtnId = "setupComplete.dismissButton"
    }
    
    // MARK: ELEMENTS
    private lazy var letsGetStartedBtn = app.buttons.matching(identifier: Identifier.letsGetStartedBtnId).firstMatch
  
    // MARK: METHODS - ACTION
    @discardableResult
    func dismissLetsGetStartedScreen() -> Self {
        expect(element: letsGetStartedBtn, status: .hittable).tap()
        return self
    }
}
