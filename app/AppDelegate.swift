//
//  AppDelegate.swift
//  ios-golden-sample-app
//
//  Created by Backbase on 29/06/2023.
//

import UIKit
import Resolver
import Backbase
import IdentityAuthenticationJourney

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // MARK: Properties
    let configuration: AppConfiguration = AppConfiguration()

    // MARK: Default methods

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = createWindow()
        self.window = window
        configuration.registerDependencies()

        setupObservability()
        appendCustomHeader()
        UserProfileUseCaseHelper().setupUserProfileUseCase()

        configuration.router.didStartApp(window)
        let authenticationUseCase = Resolver.resolve(AuthenticationUseCase.self)
        authenticationUseCase.validateSession(callback: { _ in })
        return true
    }

    override init() {
        super.init()

        setupBackbaseSDK()
    }

    private func createWindow() -> UIWindow {
        let newWindow = UIWindow()
        newWindow.makeKeyAndVisible()
        return newWindow
    }
}
