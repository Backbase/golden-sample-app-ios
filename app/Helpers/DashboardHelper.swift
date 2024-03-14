//
//  Created by Backbase on 13/02/2024.
//

import BackbaseDesignSystem
import UIKit
import AccountsJourney
import GoldenAccountsUseCase
import Resolver
import UserManagerUserProfileUseCase
import UserProfileJourney
import IdentityAuthenticationJourney

private struct UserPresentable: TabHeaderViewControllerUserPresentable {
    var name: String
    var company: String?
    var image: UIImage?
}

/// A helper struct to setup the dashboard.
struct DashboardHelper {
    static func build(serviceAgreementName: String) -> (UINavigationController) -> UIViewController {
        { navigationController in
            let authenticationUseCase = Resolver.resolve(AuthenticationUseCase.self)
            let userProfileName = authenticationUseCase.cachedName ?? ""
            return createTabHeaderViewController(navigationController, userProfileName, serviceAgreementName)
        }
    }

    private static func createTabHeaderViewController(_ navigationController: UINavigationController,
                                                      _ userName: String,
                                                      _ serviceAgreementName: String) -> UIViewController {
        let accountsListViewController = AccountsList.build(navigationController: navigationController)
        accountsListViewController.title = Bundle.main.localize("accountsJourney.accountsList.labels.title") ?? ""
        let tab2ViewController = ComingSoonViewController(title: Bundle.main.localize("dashboard.menu.tab2") ?? "")
        let tab3ViewController = ComingSoonViewController(title: Bundle.main.localize("dashboard.menu.tab3") ?? "")

        let userPresentable = UserPresentable(name: userName, company: serviceAgreementName, image: nil)
        let headerConfiguration = TabHeaderViewController.Header.UserInformationConfiguration(userPresentable: userPresentable)
        let header: TabHeaderViewController.Header = .userInformation(headerConfiguration)

        let tabHeaderViewControllerConfiguration = TabHeaderViewController.Configuration(header: header,
                                                                                         viewControllers: [accountsListViewController,
                                                                                                           tab2ViewController,
                                                                                                           tab3ViewController])

        let tabHeaderController = TabHeaderViewController(configuration: tabHeaderViewControllerConfiguration)
        tabHeaderController.title = Bundle.main.localize("tabBar.dashboard.tabTitle") ?? ""
        tabHeaderController.tabBarItem.image = UIImage(systemName: "filemenu.and.selection")
        return tabHeaderController
    }
}
