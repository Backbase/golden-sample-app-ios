//
//  Created by Backbase on 31/01/2024.
//

import BackbaseDesignSystem
import UIKit
import AccountsJourney
import GoldenAccountsUseCase

struct DummyUser: TabHeaderViewControllerUserPresentable {
    var name: String
    var company: String?
    var image: UIImage?
}

extension AppDelegate {
    
    func getDashboardTabHeaderViewController(navigationController: UINavigationController) -> TabHeaderViewController {
        let accountsListViewController = AccountsList.build(navigationController: navigationController)
        accountsListViewController.title = Bundle.main.localize("accountsJourney.accountsList.labels.title") ?? ""
        let tab2ViewController = ComingSoonViewController(title: Bundle.main.localize("dashboard.menu.tab2") ?? "")
        let tab3ViewController = ComingSoonViewController(title: Bundle.main.localize("dashboard.menu.tab3") ?? "")

        let userPresentable = DummyUser(name: "Test User", company: "Test User", image: nil) // TODO figure out the right user

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
