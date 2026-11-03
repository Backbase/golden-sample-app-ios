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

        #expect(viewController is UIHostingController<AccountsListView<AccountsListViewModel>>)
    }

    @Test
    func build_routesTheSelection_throughTheConfiguredRouter_ofTheGivenNavigationController() throws {
        var configuration = AccountsJourney.Configuration()
        var routed: (navigationController: UINavigationController, id: String)?
        configuration.accountsList.router = AccountsList.Router(didSelectProduct: { navigationController in
            { id in routed = (navigationController, id) }
        })
        register(configuration)
        defer { register() }
        let navigationController = UINavigationController()

        let viewController = AccountsList.build(navigationController: navigationController)
        let hostingController = try #require(viewController as? UIHostingController<AccountsListView<AccountsListViewModel>>)
        try viewModel(of: hostingController.rootView).select(accountID: "loan-1")

        #expect(routed?.navigationController === navigationController)
        #expect(routed?.id == "loan-1")
    }

    /// The view keeps its view model private, so it is read back by reflection.
    private func viewModel(of view: AccountsListView<AccountsListViewModel>) throws -> AccountsListViewModel {
        let child = try #require(Mirror(reflecting: view).children.first { $0.label == "_viewModel" })
        return try #require((child.value as? Bindable<AccountsListViewModel>)?.wrappedValue)
    }
}
