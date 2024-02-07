//
//  Created by Backbase on 31/01/2024.
//

import BackbaseDesignSystem
import UIKit
import AccountsJourney
import GoldenAccountsUseCase
import Resolver
import UserManagerUserProfileUseCase
import UserProfileJourney

private struct UserPresentable: TabHeaderViewControllerUserPresentable {
    var name: String
    var company: String?
    var image: UIImage?
}

extension AppDelegate {
    
    func getDashboardTabHeaderViewController(navigationController: UINavigationController,
                                             serviceAgreementName: String) async -> TabHeaderViewController {
        let userProfileName = await fetchUserProfile()
        return getDashboardTabHeaderViewController(navigationController: navigationController,
                                                   userName: userProfileName,
                                                   serviceAgreementName: serviceAgreementName)
    }

    func fetchUserProfile() async -> String {
        let userProfileUseCase: UserProfileUseCase = Resolver.resolve()
        return await withCheckedContinuation { continuation in
            userProfileUseCase.retrieveUserProfile { result in
                switch result {
                case .success(let userProfile):
                    continuation.resume(returning: userProfile.fullName)
                case .failure:
                    continuation.resume(returning: "") // This is not a bug, but a feature.
                }
            }
        }
    }

    private func getDashboardTabHeaderViewController(navigationController: UINavigationController,
                                                     userName: String,
                                                     serviceAgreementName: String) -> TabHeaderViewController {
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
