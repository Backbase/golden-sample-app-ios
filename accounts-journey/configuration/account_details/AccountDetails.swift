//
//  AccountDetails.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 28/11/2023.
//

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
}
