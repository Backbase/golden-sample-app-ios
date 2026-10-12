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
    /// Main entry point to the AccountDetails. This is the composition root: the use case and the tracker
    /// are resolved here and handed to the view model.
    /// - Returns: a UIViewController hosting the SwiftUI screen
    @MainActor
    public static func build(
        navigationController: UINavigationController,
        arrangementId: String
    ) -> UIViewController {
        let configuration: AccountsJourney.Configuration = Resolver.resolve()
        let viewModel = AccountDetailsViewModel(
            arrangementId: arrangementId,
            useCase: Resolver.resolve(AccountDetailsUseCase.self),
            configuration: configuration,
            tracker: Resolver.optional()
        )
        return UIHostingController(rootView: AccountDetailsView(viewModel: viewModel, configuration: configuration))
    }
}
