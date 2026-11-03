//
//  ScreenSnapshotTestCase.swift
//  SnapshotTests
//

import Resolver
import SnapshotTesting
import SwiftUI
import UIKit
import XCTest
@testable import AccountsJourney

/// Base class of the screen snapshot tests.
///
/// Registers the journey configuration, which some of the localised strings are resolved with, and
/// renders a screen once per `Simulator` of the active test plan configuration.
@MainActor
class ScreenSnapshotTestCase: XCTestCase {

    let journeyConfiguration = AccountsJourney.Configuration()

    override func setUp() {
        super.setUp()
        UIView.setAnimationsEnabled(false)
        Resolver.register { [journeyConfiguration] in journeyConfiguration }
    }

    /// The `English` test plan configuration covers light and dark mode in left to right layout,
    /// any other language covers right to left layout in light mode. Without a test plan it is `English`.
    var simulatorsForTestConfiguration: [Simulator] {
        switch ProcessInfo.processInfo.environment["TestPlanLanguage"] {
        case nil, "en": return Simulator.leftToRightWithDarkMode
        default: return Simulator.rightToLeftLightMode
        }
    }

    /// Asserts that the screen looks like its reference images, one per simulator.
    /// - Parameters:
    ///   - viewController: The screen to render.
    ///   - nameSuffix: Tells apart several snapshots taken in one test.
    func assertScreenSnapshot(
        of viewController: UIViewController,
        nameSuffix: String? = nil,
        file: StaticString = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        let name = nameSuffix.map { "\(function)_\($0)" } ?? function

        for simulator in simulatorsForTestConfiguration {
            let failure = verifySnapshot(
                of: viewController,
                as: .image(
                    on: simulator.config,
                    precision: 0.99,
                    perceptualPrecision: 0.98,
                    traits: simulator.config.traits
                ),
                named: name,
                file: file,
                testName: simulator.viewDescription,
                line: line
            )
            if let failure {
                XCTFail(failure, file: file, line: line)
            }
        }
    }
}
