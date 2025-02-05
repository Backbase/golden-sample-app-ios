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

open class AppDelegate<Router: AppRouter>: UIResponder, UIApplicationDelegate {
    public var window: UIWindow?
    
    override public init() {
        super.init()
        setupBackbaseSDK()
    }
    
    open func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let window = createWindow()
        self.window = window
        
        let router = Router()
        Resolver.register { router }.implements(AppRouter.self)
        
        
        Splash.Configuration.appDefault.register()
        Authentication.Configuration.appDefault.register(sessionChangeHandler: router.handleSessionChange(newSession: ))
        
        router.didStartApp(window: window)
        
        return true
    }
    
    private func createWindow() -> UIWindow {
        let newWindow = UIWindow()
        newWindow.makeKeyAndVisible()
        return newWindow
    }
}
