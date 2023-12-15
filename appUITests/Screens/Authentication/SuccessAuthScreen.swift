//
//  UIConstants.swift
//  GoldenSampleUITests
//
//  Created by Backbase on 15/12/2023.
//

import Foundation

class SetupCompleteScreen : BaseScreen {
    
    //MARK: ELEMENTS
    private lazy var letsGetStartedButton = app.buttons.matching(identifier: "setupComplete.dismissButton").firstMatch
  
    //MARK: METHODS - ACTION
    func dismissLetsGetStartedScreen() {
        letsGetStartedButton.tap()
    }
}
