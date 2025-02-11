//
//  Router.swift
//  GoldenSampleApp
//
//  Created by Backbase on 04/02/2025.
//

import UIKit
import Resolver
import AppCommon
import RetailMoreJourney
import BackbaseDesignSystem
import BusinessJourneyCommon
import BusinessWorkspacesJourney

final class Router: AppRouter {
    override func didFinishLogin(navigationController: UINavigationController) {
        let dashboardHelper = DashboardHelper()
        let moreNavigationController = NavigationController()
        let moreViewController = More.build(navigationController: moreNavigationController)
        
        let userRepository = Resolver.resolve(UserRepository.self)
        
        moreNavigationController.viewControllers = [moreViewController]
        
        let tabBarViewController = BackbaseDesignSystem.TabBarController()
        Task {
            let dashboardViewController = await dashboardHelper.getViewController(
                navigationController: navigationController,
                serviceAgreementName: userRepository.persistedServiceAgreementName ?? ""
            )
            
            DispatchQueue.main.async {[weak self] in
                guard let self else { return }
                tabBarViewController.viewControllers = [
                    dashboardViewController,
                    moreNavigationController
                ]
                
                self.set(viewController: tabBarViewController)
            }
        }
    }
}
