//
//  AccountDetails.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 28/11/2023.
//

import Resolver
import SwiftUI
import UIKit

public struct AccountDetails {
    /// Main entry point to the AccountDetails
    public static func build(
        navigationController: UINavigationController,
        arrangementId: String
    ) -> UIViewController {
        let viewModel = AccountDetailsViewModel()
        let viewController = AccountDetailsViewController(viewModel: viewModel, arrangementId: arrangementId)
        return viewController
    }

    /// Entry point to the SwiftUI AccountDetails. Same behaviour as ``build(navigationController:arrangementId:)``,
    /// the screen is just rendered by `AccountDetailsView` instead of `AccountDetailsViewController`.
    /// - Returns: a UIViewController hosting the SwiftUI screen
    @MainActor
    public static func buildSwiftUI(
        navigationController: UINavigationController,
        arrangementId: String
    ) -> UIViewController {
        let configuration: AccountsJourney.Configuration = Resolver.resolve()
        let viewModel = AccountDetailsViewModel()
        return UIHostingController(
            rootView: AccountDetailsView(viewModel: viewModel, arrangementId: arrangementId, configuration: configuration)
        )
    }
}
