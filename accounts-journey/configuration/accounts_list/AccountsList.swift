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
    /// are resolved here and handed to the view model.
    /// - Returns: a UIViewController hosting the SwiftUI screen
    /// - Parameter navigationController: UINavigationController
    @MainActor
    public static func build(navigationController: UINavigationController) -> UIViewController {
        let configuration: AccountsJourney.Configuration = Resolver.resolve()
        let viewModel = AccountsListViewModel(
            useCase: Resolver.resolve(AccountsListUseCase.self),
            configuration: configuration,
            tracker: Resolver.optional(),
            didSelectProduct: configuration.accountsList.router.didSelectProduct(navigationController)
        )
        return UIHostingController(rootView: AccountsListView(viewModel: viewModel, configuration: configuration))
    }
}
