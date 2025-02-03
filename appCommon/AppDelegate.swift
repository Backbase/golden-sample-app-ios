//
//  AppDelegate.swift
//  AppCommon
//
//  Created by Backbase on 03/02/2025.
//

import UIKit
import Resolver
import Backbase

open class AppDelegate<Router: AppRouter>: UIResponder, UIApplicationDelegate {
    public var window: UIWindow?
    
    override public init() {
        super.init()
        setupBackbaseSDK()
    }
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let window = createWindow()
        self.window = window
        
        let router = AppRouter()
        Resolver.register { router }.implements(AppRouter.self)
        
        router.didStartApp(window: window)
        
        return true
    }
    
    private func createWindow() -> UIWindow {
        let newWindow = UIWindow()
        newWindow.makeKeyAndVisible()
        return newWindow
    }
}
