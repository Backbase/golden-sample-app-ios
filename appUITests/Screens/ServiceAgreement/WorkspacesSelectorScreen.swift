//
//  UIConstants.swift
//  GoldenSampleUITests
//
//  Created by Backbase on 15/12/2023.
//

import Foundation
import XCTest

final class WorkspacesSelectorScreen: BaseScreen {
    
    private enum Identifier {
            static let workspacesSelectorScreenTitleLblId = "workspaceSelectorView.screenTitle"
        }

    // MARK: ELEMENTS
    private lazy var workspacesSelectorScreenTitleLbl = app.staticTexts.matching(identifier: Identifier.workspacesSelectorScreenTitleLblId).firstMatch
    private lazy var workspacesTbl = XCUIApplication().tables.element(boundBy: 0).firstMatch
    private lazy var workspacesLoadingView = XCUIApplication().activityIndicators.element(boundBy: 0).firstMatch
    
    // MARK: METHODS - ACTION
    @discardableResult
    func selectWorkspaceBy(position: Int) -> Self {
        let selectedWorkspace = workspacesTbl.cells.element(boundBy: position)
        selectedWorkspace.tap()
        return self
    }
    
    @discardableResult
    func selectWorkspaceBy(text: String) -> Self {
        let selectedWorkspace = app.staticTexts[text].firstMatch
        expect(element: selectedWorkspace, status: .hittable).tap()
        return self
    }
    
    @discardableResult
    func selectServiceAgreementIfNeeded(workspaceName: String) -> Self {
        expect(element: workspacesSelectorScreenTitleLbl, status: .exist)
        selectWorkspaceBy(text: workspaceName)
        return self
    }
    
    // MARK: Other Method
    func countWorkspaces() -> Int {
        return workspacesTbl.cells.count
    }
}
