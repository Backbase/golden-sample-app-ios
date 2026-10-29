//
//  AccountDetailsScreenSnapshotTests.swift
//  SnapshotTests
//

import SwiftUI
import UIKit
import XCTest
@testable import AccountsJourney

/// Snapshots of the account details in each of its states. The screen is the real `AccountDetailsView`
/// pushed on a navigation controller the way the accounts list pushes it, driven by a mocked use case.
final class AccountDetailsScreenSnapshotTests: ScreenSnapshotTestCase {

    // MARK: - Tests

    func testLoaded() async {
        let viewController = await screen(.success())

        assertScreenSnapshot(of: viewController)
    }

    func testLoading() async {
        let viewController = await screen(.neverCompletes)

        assertScreenSnapshot(of: viewController)
    }

    func testError() async {
        let viewController = await screen(.failure)

        assertScreenSnapshot(of: viewController)
    }

    // MARK: - Private

    /// Builds the screen and loads it before it is rendered.
    private func screen(_ behaviour: MockAccountDetailsUseCase.Behaviour) async -> UIViewController {
        let model = AccountDetailsModel(
            arrangementId: "arrangement-id",
            useCase: MockAccountDetailsUseCase(behaviour)
        )
        let viewModel = AccountDetailsViewModel(model: model, configuration: journeyConfiguration)
        // A load that never completes would suspend the test, so only the others are awaited.
        if case .neverCompletes = behaviour {
            // The screen starts loading: nothing to arrange.
        } else {
            await viewModel.loadIfNeeded()
        }
        let hostingController = UIHostingController(
            rootView: AccountDetailsView(viewModel: viewModel, configuration: journeyConfiguration)
        )
        return UINavigationController(rootViewController: hostingController)
    }
}
