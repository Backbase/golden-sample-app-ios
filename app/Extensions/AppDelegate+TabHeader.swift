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
        accountsListViewController.title = Bundle.main.localize("accountsJourney.accountsList.labels.title") ?? "" // TODO find another way

        let tab2Title = Bundle.main.localize("dashboard.menu.tab2") ?? "" // TODO find another way
        let tab2ViewController = CustomTabHeaderViewController(title: tab2Title)

        let tab3Title = Bundle.main.localize("dashboard.menu.tab3") ?? "" // TODO find another way
        let tab3ViewController = CustomTabHeaderViewController(title: tab3Title)

        let userPresentable = DummyUser(name: "Test User", company: "Test User", image: nil) // TODO figure out the right user

        let headerConfiguration = TabHeaderViewController.Header.UserInformationConfiguration(userPresentable: userPresentable)
        let header: TabHeaderViewController.Header = .userInformation(headerConfiguration)

        let tabHeaderViewControllerConfiguration = TabHeaderViewController.Configuration(header: header,
                                                                                         viewControllers: [accountsListViewController,
                                                                                                           tab2ViewController,
                                                                                                           tab3ViewController])
        return TabHeaderViewController(configuration: tabHeaderViewControllerConfiguration)
    }
}
