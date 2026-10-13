//
//  AccountsListScreenSnapshotTests.swift
//  SnapshotTests
//

import SwiftUI
import UIKit
import XCTest
@testable import AccountsJourney

/// Snapshots of the accounts list in each of its states. The screen is the real `AccountsListView`
/// hosted the way the app hosts it, driven by a mocked use case.
final class AccountsListScreenSnapshotTests: ScreenSnapshotTestCase {

    // MARK: - Tests

    func testLoaded() async {
        let viewController = await screen(.success())

        assertScreenSnapshot(of: viewController)
    }

    func testLoading() async {
        let viewController = await screen(.neverCompletes)

        assertScreenSnapshot(of: viewController)
    }

    func testEmpty() async {
        let viewController = await screen(.empty)

        assertScreenSnapshot(of: viewController)
    }

    func testError() async {
        let viewController = await screen(.failure)

        assertScreenSnapshot(of: viewController)
    }

    func testSearchWithResults() async {
        let viewController = await screen(.success()) { viewModel in
            viewModel.searchText = "savings"
            await viewModel.submitSearch(debounce: .zero)
        }

        assertScreenSnapshot(of: viewController)
    }

    func testSearchWithoutResults() async {
        let viewController = await screen(.success()) { viewModel in
            viewModel.searchText = "no such account"
            await viewModel.submitSearch(debounce: .zero)
        }

        assertScreenSnapshot(of: viewController)
    }

    // MARK: - Private

    /// Builds the screen and brings its view model to the state under test before the screen is rendered.
    private func screen(
        _ behaviour: MockAccountsListUseCase.Behaviour,
        arranging arrange: (AccountsListViewModel) async -> Void = { _ in }
    ) async -> UIViewController {
        let viewModel = AccountsListViewModel(
            useCase: MockAccountsListUseCase(behaviour),
            configuration: journeyConfiguration
        )
        // A load that never completes would suspend the test, so only the others are awaited.
        if case .neverCompletes = behaviour {
            // The screen starts loading: nothing to arrange.
        } else {
            await viewModel.loadAccountsIfNeeded()
            await arrange(viewModel)
        }
        return UIHostingController(rootView: AccountsListView(viewModel: viewModel, configuration: journeyConfiguration))
    }
}
