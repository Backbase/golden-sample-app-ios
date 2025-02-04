//
//  Splash.swift
//  AppCommon
//
//  Created by George Nyakundi on 04/02/2025.
//

import UIKit

public struct Splash {
    /// Entry point for the Splash screen
    public static func build(navigationController: UINavigationController) -> UIViewController {
        return SplashViewController()
    }
}
