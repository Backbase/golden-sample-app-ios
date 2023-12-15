//
//  UIConstants.swift
//  GoldenSampleUITests
//
//  Created by Backbase on 15/12/2023.
//

import Foundation
import XCTest

class WorkspacesSelectorScreen : BaseScreen {

    //MARK: ELEMENTS
    private lazy var workspacesSelectorScreenTitle = app.staticTexts.matching(identifier: "workspaceSelectorView.screenTitle").firstMatch
    private lazy var workspacesTableView = XCUIApplication().tables.element(boundBy: 0).firstMatch
    private lazy var workspacesLoadingView = XCUIApplication().activityIndicators.element(boundBy: 0).firstMatch
    
    //MARK: METHODS - ACTION
    func selectWorkspaceBy(position: Int) {
        let selectedWorkspace = workspacesTableView.cells.element(boundBy: position)
        selectedWorkspace.tap()
    }
    
    func selectWorkspaceBy(text: String) {
        let selectedWorkspace = app.staticTexts[text]
        selectedWorkspace.waitForElementToAppear()
        selectedWorkspace.tap()
    }
    
    func selectServiceAgreementIfNeeded(workspaceName: String) {
        if (workspacesSelectorScreenTitle.exists) {
            selectWorkspaceBy(text: workspaceName)
        }
    }
    
    //MARK: Other Method
    func countWorkspaces() -> Int {
        return workspacesTableView.cells.count
    }

}
