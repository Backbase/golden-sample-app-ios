//
//  Created by Backbase R&D B.V. on 07/12/2022.
//

import XCTest
import SnapshotTesting
import BackbaseDesignSystem
import SwiftUI

extension XCTestCase {

    // MARK: - Snapshot testing helper methods

    /// Asserts and verifies given view controller
    ///  - Parameters:
    ///     - viewController: view controller to verify
    ///     - waitTime: waiting time before timing out while verifying an image
    ///     - file: File name of the snapshot test class
    ///     - function: A unique method name of the snapshot test to be used to attach to the name of the image
    ///     - named: Optional name to attach to the snapshot test. By default it uses the name of the method from `function` parameter.
    ///  - Returns: A list of error descriptons in case existing image did not match with the created image.
    func verifyViewControllerSnapshot(with viewController: UIViewController,
                                      testCases: [Simulator] = Simulator.leftToRightLightMode,
                                      waitTime: TimeInterval = 0,
                                      file: StaticString = #file,
                                      function: String = #function,
                                      snapshotNameSuffix: String? = nil,
                                      containerBackgroundColor: UIColor = DesignSystem.shared.colors.surfacePrimary.default) -> [String] {

        viewController.view.backgroundColor = containerBackgroundColor
        disableAnimationsAndTransitions(viewController: viewController)
        return testCases.compactMap {
            let imageName = snapshotNameSuffix == nil ? function : "\(function)\(snapshotNameSuffix!)"
            let result = SnapshotTesting.verifySnapshot(matching: viewController,
                                                        as: .wait(for: waitTime,
                                                                  on: .image(on: $0.config, precision: 1)),
                                                        named: imageName,
                                                        file: file,
                                                        testName: "\($0.description)")
            return result
        }
    }

    /// Asserts and verifies given view controller
    ///  - Parameters:
    ///     - view: view to verify
    ///     - waitTime: waiting time before timing out while verifying an image
    ///     - file: File name of the snapshot test class
    ///     - function: A unique method name of the snapshot test to be used to attach to the name of the image
    ///     - named: Optional name to attach to the snapshot test. By default it uses the name of the method from `function` parameter.
    ///     - containerBackgroundColor: Sets the background color of the viewController.view. By default set to `.gray` color.
    ///  - Returns: A list of error descriptions in case existing image did not match with the created image.
    func verifyViewSnapshot(with view: UIView,
                            testCases: [Simulator] = Simulator.allCases,
                            waitTime: TimeInterval = 0,
                            file: StaticString = #file,
                            function: String = #function,
                            snapshotNameSuffix: String? = nil) -> [String] {
        return testCases.compactMap {
            UIView.setAnimationsEnabled(false)
            
            let imageName = snapshotNameSuffix == nil ? function : "\(function)\(snapshotNameSuffix!)"
            let result = SnapshotTesting.verifySnapshot(matching: view,
                                                        as: .wait(for: waitTime,
                                                                  on: .image(precision: 1, traits: $0.config.traits)),
                                                        named: imageName,
                                                        file: file,
                                                        testName: "\($0.viewDescription)")
            return result
        }
    }
    
    /// Asserts and verifies given view controller
    ///  - Parameters:
    ///     - view: view to verify
    ///     - waitTime: waiting time before timing out while verifying an image
    ///     - file: File name of the snapshot test class
    ///     - function: A unique method name of the snapshot test to be used to attach to the name of the image
    ///     - named: Optional name to attach to the snapshot test. By default it uses the name of the method from `function` parameter.
    ///     - containerBackgroundColor: Sets the background color of the viewController.view. By default set to `.gray` color.
    ///  - Returns: A list of error descriptions in case existing image did not match with the created image.
    func verifyViewSnapshot(with view: some View,
                            testCases: [Simulator] = Simulator.leftToRightWithDarkMode,
                            waitTime: TimeInterval = 0,
                            file: StaticString = #file,
                            function: String = #function,
                            snapshotNameSuffix: String? = nil) -> [String] {
        
        let uiView: UIView = UIHostingController(rootView: view).view
        uiView.backgroundColor = DesignSystem.shared.colors.foundation.default
        uiView.layoutSubviews()
        
        return testCases.compactMap {
            UIView.setAnimationsEnabled(false)
            
            let imageName = snapshotNameSuffix == nil ? function : "\(function)\(snapshotNameSuffix!)"
            let result = SnapshotTesting.verifySnapshot(matching: uiView,
                                                        as: .wait(for: waitTime,
                                                                  on: .image(precision: 1,
                                                                             size: uiView.intrinsicContentSize,
                                                                             traits: $0.config.traits)),
                                                        named: imageName,
                                                        file: file,
                                                        testName: "\($0.viewDescription)")
            return result
        }
    }

    // MARK: - Helper view methods

    /// Returns a vertical stack view with the given subviews and background color but is also styled to look good as a background for snapshot testing.
    func containerStackView(arrangedSubviews: [UIView], backgroundColor: UIColor? = nil) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = backgroundColor
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.layer.cornerRadius = 12
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }

    // MARK: - Private
    
    func disableAnimationsAndTransitions(viewController: UIViewController) {
        UIView.setAnimationsEnabled(false)
        viewController.beginAppearanceTransition(true, animated: false)
        viewController.endAppearanceTransition()
    }
}
