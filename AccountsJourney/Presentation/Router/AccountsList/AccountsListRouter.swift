//
//  AccountsListRouter.swift
//  AccountsJourney
//

import UIKit

/// Navigates away from the accounts list.
///
/// It binds the `UINavigationController` of the screen to the public ``AccountsList/Router`` hook of the
/// configuration, which stays the extension point integrators use to customise the navigation.
@MainActor
final class AccountsListRouter: AccountsListRouting {

    /// Weak: the navigation controller owns the screen, which owns the view model, the model and this router.
    private weak var navigationController: UINavigationController?
    private let routerConfiguration: AccountsList.Router

    /// - Parameters:
    ///   - navigationController: The navigation controller the accounts list is shown in.
    ///   - routerConfiguration: The configured navigation hook.
    init(navigationController: UINavigationController, routerConfiguration: AccountsList.Router) {
        self.navigationController = navigationController
        self.routerConfiguration = routerConfiguration
    }

    func navigateToDetails(ofAccountWithID id: String) {
        guard let navigationController else { return }
        routerConfiguration.didSelectProduct(navigationController)(id)
    }
}
