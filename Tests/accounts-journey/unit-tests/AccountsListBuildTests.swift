import ArrangementsClient2Gen2
import ClientCommonGen2
import Resolver
import SwiftUI
import Testing
import UIKit
@testable import AccountsJourney

// MARK: - Entry point

/// `AccountsList.build(navigationController:)`, the entry point of the screen. It is the composition root,
/// so it resolves its dependencies from the global `Resolver`: the suite is serialized and puts it back.
@Suite("AccountsList.build", .serialized)
@MainActor
struct AccountsListBuildTests {

    private func register(_ configuration: AccountsJourney.Configuration = AccountsJourney.Configuration()) {
        let useCase = StubAccountsListUseCase(result: Self.failure)
        Resolver.register { useCase as AccountsListUseCase }
        Resolver.register { configuration }
    }

    private static let failure = Result<ProductSummary, ErrorResponse>.failure(.error(500, nil, AccountsList.Error.invalidResponse))

    @Test
    func build_returnsAHostingControllerForTheSwiftUIScreen() {
        register()
        defer { register() }

        let viewController = AccountsList.build(navigationController: UINavigationController())

        #expect(viewController is UIHostingController<AccountsListView>)
    }

    @Test
    func build_asksTheRouterForTheSelectionHandler_ofTheGivenNavigationController() {
        var configuration = AccountsJourney.Configuration()
        var routedNavigationController: UINavigationController?
        configuration.accountsList.router = AccountsList.Router(didSelectProduct: { navigationController in
            routedNavigationController = navigationController
            return { _ in }
        })
        register(configuration)
        defer { register() }
        let navigationController = UINavigationController()

        _ = AccountsList.build(navigationController: navigationController)

        #expect(routedNavigationController === navigationController)
    }
}
