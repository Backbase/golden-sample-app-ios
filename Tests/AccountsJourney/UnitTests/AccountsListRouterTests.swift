import Testing
import UIKit
@testable import AccountsJourney

// MARK: - Router

/// `AccountsListRouter` binds the navigation controller of the screen to the configured router hook.
@Suite("AccountsListRouter")
@MainActor
struct AccountsListRouterTests {

    @Test
    func navigateToDetails_callsTheConfiguredHook_withTheNavigationControllerAndTheID() {
        var received: (navigationController: UINavigationController, id: String)?
        let navigationController = UINavigationController()
        let router = AccountsListRouter(
            navigationController: navigationController,
            routerConfiguration: AccountsList.Router(didSelectProduct: { navigationController in
                { id in received = (navigationController, id) }
            })
        )

        router.navigateToDetails(ofAccountWithID: "loan-1")

        #expect(received?.navigationController === navigationController)
        #expect(received?.id == "loan-1")
    }

    @Test
    func navigateToDetails_doesNothing_onceTheNavigationControllerIsGone() {
        var hookCalls = 0
        var navigationController: UINavigationController? = UINavigationController()
        let router = AccountsListRouter(
            navigationController: navigationController!,
            routerConfiguration: AccountsList.Router(didSelectProduct: { _ in
                { _ in hookCalls += 1 }
            })
        )
        navigationController = nil

        router.navigateToDetails(ofAccountWithID: "loan-1")

        #expect(hookCalls == 0)
    }
}
