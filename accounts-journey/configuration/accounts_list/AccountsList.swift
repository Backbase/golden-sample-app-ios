//
//  AccountsList.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 27/11/2023.
//

import UIKit
import Resolver

public struct AccountsList {
    /// Main entry point to the AccountsList
    /// - Returns: a UIViewController 
    /// - Parameter navigationController: UINavigationController
    public static func build(navigationController: UINavigationController) -> UIViewController {
        let configuration: AccountsJourney.Configuration = Resolver.resolve()
        let viewModel = AccountsListViewModel()
        viewModel.didSelectProduct = configuration.accountsList.router.didSelectProduct(navigationController)
        let viewController = AccountsListViewController(viewModel: viewModel)
        return viewController
    }
}
