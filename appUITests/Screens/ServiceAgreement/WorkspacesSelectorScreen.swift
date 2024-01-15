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
    private lazy var workspacesSelectorScreenTitleLbl = app.staticTexts.matching(identifier: "workspaceSelectorView.screenTitle").firstMatch
    private lazy var workspacesTbl = XCUIApplication().tables.element(boundBy: 0).firstMatch
    private lazy var workspacesLoadingView = XCUIApplication().activityIndicators.element(boundBy: 0).firstMatch
    
    //MARK: METHODS - ACTION
    func selectWorkspaceBy(position: Int) {
        let selectedWorkspace = workspacesTbl.cells.element(boundBy: position)
        selectedWorkspace.tap()
    }
    
    func selectWorkspaceBy(text: String) {
        let selectedWorkspace = app.staticTexts[text]
        expect(element: selectedWorkspace, status: .hittable, timeout: Timeouts.defaultTimeout).tap()
    }
    
    func selectServiceAgreementIfNeeded(workspaceName: String) {
        expect(element: workspacesSelectorScreenTitleLbl, status: .exist, timeout: Timeouts.defaultTimeout)
        selectWorkspaceBy(text: workspaceName)
    }
    
    //MARK: Other Method
    func countWorkspaces() -> Int {
        return workspacesTbl.cells.count
    }

}
