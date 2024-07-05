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
        let headerConfiguration = TabHeaderViewController.Header.UserInformationConfiguration(userPresentable: userPresentable,
                                                                                              trailingView: createThemeSwitcherView(navigationController))
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
    
    private func createThemeSwitcherView(_ navigationController: UINavigationController) -> UIView {
        let trailingView = UIButton()
        trailingView.accessibilityLabel = Bundle.main.localize("tabBar.dashboard.themeSwitchButtonTitle")
        trailingView.accessibilityTraits = UIAccessibilityTraits.button
        trailingView.contentHorizontalAlignment = .trailing
        trailingView.setTitle(Bundle.main.localize("tabBar.dashboard.themeSwitchButtonTitle"), for: .normal)
        trailingView.titleLabel?.adjustsFontForContentSizeCategory = true
        trailingView.tintColor = Theme.colors.onBackground.brand
        trailingView.addAction(UIAction { _ in
            let actionSheet = UIAlertController(title: Bundle.main.localize("tabBar.dashboard.themeSwitchActionTitle"),
                                                message: Bundle.main.localize("tabBar.dashboard.themeSwitchActionMessage"),
                                                preferredStyle: .actionSheet)
            
            let option1 = UIAlertAction(title: "Default", style: .default) { _ in
                self.changeTheme("defaultTheme")
            }
            
            let option2 = UIAlertAction(title: "Premium", style: .default) { _ in
                self.changeTheme("premiumTheme")
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                
            }
            
            actionSheet.addAction(option1)
            actionSheet.addAction(option2)
            actionSheet.addAction(cancelAction)
            
            navigationController.present(actionSheet, animated: true, completion: nil)
        }, for: .touchUpInside)
        
        return trailingView
    }
        
    func changeTheme(_ filename: String) {
        Theme.switchTo(filename)
        let useCase: AuthenticationUseCase = Resolver.resolve()
        useCase.endSession(callback: nil)
    }
}
