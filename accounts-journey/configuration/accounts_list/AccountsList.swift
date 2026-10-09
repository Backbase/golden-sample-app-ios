//
//  AccountsList.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 27/11/2023.
//

import Resolver
import SwiftUI
import UIKit

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

    /// Entry point to the SwiftUI AccountsList. Same behaviour as ``build(navigationController:)``,
    /// the screen is just rendered by `AccountsListView` instead of `AccountsListViewController`.
    /// - Returns: a UIViewController hosting the SwiftUI screen
    /// - Parameter navigationController: UINavigationController
    @MainActor
    public static func buildSwiftUI(navigationController: UINavigationController) -> UIViewController {
        let configuration: AccountsJourney.Configuration = Resolver.resolve()
        let viewModel = AccountsListViewModel()
        viewModel.didSelectProduct = configuration.accountsList.router.didSelectProduct(navigationController)
        return UIHostingController(rootView: AccountsListView(viewModel: viewModel, configuration: configuration))
    }
}
