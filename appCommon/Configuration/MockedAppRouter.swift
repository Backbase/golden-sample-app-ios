//
//  MockedAppRouter.swift
//  ios-golden-sample-app
//
//  Created by George Nyakundi on 26/05/2025.
//
#if DEBUG
import UIKit
import BackbaseDesignSystem
import AccountsJourney

class MockedAppRouter: AppRouter {
    private var navigationController: UINavigationController = NavigationController()
    
    override func didStartApp(window: UIWindow) {
        let vc = AccountsList.build(navigationController: self.navigationController)
        navigationController.viewControllers = [vc]
        window.rootViewController = navigationController
    }
}
#endif
