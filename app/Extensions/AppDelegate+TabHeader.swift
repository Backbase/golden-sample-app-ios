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
    
    func getDashboardTabHeaderViewController(navigationController: UINavigationController,
                                             name: String,
                                             description: String) -> TabHeaderViewController {
        let accountsListViewController = AccountsList.build(navigationController: navigationController)
        accountsListViewController.title = Bundle.main.localize("accountsJourney.accountsList.labels.title") ?? ""
        let tab2ViewController = ComingSoonViewController(title: Bundle.main.localize("dashboard.menu.tab2") ?? "")
        let tab3ViewController = ComingSoonViewController(title: Bundle.main.localize("dashboard.menu.tab3") ?? "")

        let userPresentable = DummyUser(name: name, company: description, image: nil)

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
