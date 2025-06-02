//
//  Launcher.swift
//  ios-golden-sample-app
//
//  Created by George Nyakundi on 02/06/2025.
//

import Foundation
import XCTest
import AccountsJourney

class Launcher {
    var app = XCUIApplication()

    func launchApp(_ arguments: [String: String] = [:]) -> AccountsListScreen {
        app.launchArguments += ["UITests"]
        app.launchArguments += ["UseMocks"]
        arguments.forEach { app.launchEnvironment[$0.key] = $0.value }
        app.launch()
        return AccountsListScreen()

    }
}
