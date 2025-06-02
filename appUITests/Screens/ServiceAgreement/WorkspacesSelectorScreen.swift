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
        static let workspacesSelectorScreenTitleLabelIdentifier = "workspaceSelectorView.screenTitle"
    }

    // MARK: ELEMENTS
    private lazy var workspacesSelectorScreenTitleLabel = app.staticTexts.matching(identifier: Identifier.workspacesSelectorScreenTitleLabelIdentifier).firstMatch
    private lazy var workspacesTable = XCUIApplication().tables.element(boundBy: 0).firstMatch
    private lazy var workspacesLoadingView = XCUIApplication().activityIndicators.element(boundBy: 0).firstMatch
    
    // MARK: METHODS - ACTION
    @discardableResult
    func selectWorkspaceBy(position: Int) -> Self {
        let selectedWorkspace = workspacesTable.cells.element(boundBy: position)
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
        expect(element: workspacesSelectorScreenTitleLabel, status: .exist)
        selectWorkspaceBy(text: workspaceName)
        return self
    }
    
    // MARK: Other Method
    func countWorkspaces() -> Int {
        return workspacesTable.cells.count
    }
}
