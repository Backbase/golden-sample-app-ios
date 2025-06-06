//
//  MockedRouter.swift
//  ios-golden-sample-app
//
//  Created by George Nyakundi on 02/06/2025.
//

#if DEBUG
import UIKit
import BackbaseDesignSystem
import AccountsJourney

class MockedAppRouter: AppRouter {
    private var navigationController = NavigationController()

    override func didStartApp(window: UIWindow) {
        let vc = AccountsList.build(navigationController: self.navigationController)
        navigationController.viewControllers = [vc]
        window.rootViewController = navigationController
    }
}
#endif
