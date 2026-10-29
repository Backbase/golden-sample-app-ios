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
    /// Main entry point to the AccountsList. This is the composition root: the use case and the tracker
    /// are resolved here, and the router, the model and the view model are wired together.
    /// - Returns: a UIViewController hosting the SwiftUI screen
    /// - Parameter navigationController: UINavigationController
    @MainActor
    public static func build(navigationController: UINavigationController) -> UIViewController {
        let configuration: AccountsJourney.Configuration = Resolver.resolve()
        let router = AccountsListRouter(
            navigationController: navigationController,
            routerConfiguration: configuration.accountsList.router
        )
        let model = AccountsListModel(
            useCase: Resolver.resolve(AccountsListUseCase.self),
            routing: router
        )
        let viewModel = AccountsListViewModel(
            model: model,
            configuration: configuration,
            tracker: Resolver.optional()
        )
        return UIHostingController(rootView: AccountsListView(viewModel: viewModel, configuration: configuration))
    }
}
