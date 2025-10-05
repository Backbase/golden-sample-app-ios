//
//  Created by Backbase on 13/02/2024.
//

import BackbaseDesignSystem
import UIKit
import AccountsJourney
import Resolver
import UserManagerUserProfileUseCase
@preconcurrency import UserProfileJourney

private struct UserPresentable: TabHeaderViewControllerUserPresentable {
    var name: String
    var company: String?
    var image: UIImage?
}

/// A helper struct to setup the dashboard.
struct DashboardHelper {
    @MainActor
    func getViewController(navigationController: UINavigationController, serviceAgreementName: String) async -> UIViewController {
        let userProfileName = await fetchUserProfile()
        return createTabHeaderViewController(navigationController, userProfileName, serviceAgreementName)
    }

    private func fetchUserProfile() async -> String {
        let userProfileUseCase: UserProfileUseCase = Resolver.resolve()
        return await withCheckedContinuation { continuation in
            DispatchQueue.global().async {
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
    }

    private func createTabHeaderViewController(_ navigationController: UINavigationController,
                                               _ userName: String,
                                               _ serviceAgreementName: String) -> UIViewController {
        let accountsListViewController = AccountsList.build(navigationController: navigationController)
        accountsListViewController.title = Bundle.main.localize("accountsJourney.accountsList.labels.title") ?? ""
        let tab2ViewController = DemoViewController(title: Bundle.main.localize("dashboard.menu.tab2") ?? "")
        let tab3ViewController = DemoViewController(title: Bundle.main.localize("dashboard.menu.tab3") ?? "")

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
