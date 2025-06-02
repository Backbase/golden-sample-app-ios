//
//  AppDelegate.swift
//  AppCommon
//
//  Created by Backbase on 03/02/2025.
//

import UIKit
import Resolver
import Backbase
import IdentityAuthenticationJourney

/**
 * The application delegate for the app.
 *
 * This class is responsible for handling application lifecycle events, such as
 * launching, terminating, and background transitions. It sets up the main
 * window, initializes the app's router, registers it with the dependency
 * resolver, configures authentication, and starts the app's initial flow.
 * It's generic over the `AppRouter` type, allowing for customization of the
 * navigation logic.
 *
 * - Generic Parameters:
 *   - Router: The type of `AppRouter` to use for navigation.  Must conform to `AppRouter` protocol.
 */
open class AppDelegate<Router: AppRouter>: UIResponder, UIApplicationDelegate {
    
    /// The main window of the application.
    public var window: UIWindow?
    
    /// Initializes the application delegate.
    ///
    /// This initializer calls the superclass initializer and performs any
    /// necessary setup, such as initializing the Backbase SDK.
    override public init() {
        super.init()
        setupBackbaseSDK()
    }
    
    ///
    /// Called when the application has finished launching.
    ///
    /// This method is responsible for setting up the application's initial
    /// state. It creates the main window, registers the app's router with the
    /// dependency resolver, configures authentication to handle session changes
    /// via the router, and starts the app by calling `didStartApp` on the router.
    ///
    /// - Parameters:
    ///   - application: The UIApplication instance.
    ///   - launchOptions: A dictionary of launch options.
    ///
    /// - Returns: `true` if the application launch was successful, `false` otherwise.
    ///
    open func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        
        let window = createWindow()
        self.window = window
        
        setupRouter(with: window)
        
        return true
    }
    
    private func createWindow() -> UIWindow {
        let newWindow = UIWindow()
        newWindow.makeKeyAndVisible()
        return newWindow
    }
}
