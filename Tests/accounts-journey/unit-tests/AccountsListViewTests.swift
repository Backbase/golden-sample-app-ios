import ArrangementsClient2Gen2
import BackbaseObservability
import BackbaseDesignSystem
import SwiftUI
import Testing
import UIKit
@testable import AccountsJourney

// MARK: - Error state

@Suite("AccountsList.Error state view configuration")
struct AccountsListErrorStateViewConfigurationTests {

    private let journeyConfiguration = AccountsJourney.Configuration()

    @Test
    func loadingFailure_offersToRetry() throws {
        var retries = 0

        let configuration = AccountsList.Error.loadingFailure().stateViewConfiguration(configuration: journeyConfiguration) { retries += 1 }

        let button = try #require(configuration.firstButtonConfiguration)
        button.action()
        #expect(retries == 1)
    }

    @Test
    func noAccounts_hasNoAction() {
        let configuration = AccountsList.Error.noAccounts.stateViewConfiguration(configuration: journeyConfiguration) {}

        #expect(configuration.firstButtonConfiguration == nil)
    }
}

// MARK: - View

/// `AccountsListView` hosted in a window, to check that SwiftUI drives the view model:
/// `.task` loads the accounts, `.task(id:)` submits the search and `onAppear` tracks the screen view.
@Suite("AccountsListView", .timeLimit(.minutes(1)))
@MainActor
struct AccountsListViewTests {

    /// Keeps the window visible, which is what makes SwiftUI run the view's tasks.
    private func show(_ viewModel: AccountsListViewModel) -> UIWindow {
        let rootView = NavigationStack { AccountsListView(viewModel: viewModel, configuration: AccountsJourney.Configuration()) }
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 390, height: 844))
        window.rootViewController = UIHostingController(rootView: rootView)
        window.makeKeyAndVisible()
        return window
    }

    /// Lets SwiftUI run its tasks, and returns as soon as `condition` holds.
    private func wait(timeout: Duration = .seconds(5), until condition: () -> Bool) async {
        let deadline = ContinuousClock.now + timeout
        while !condition(), ContinuousClock.now < deadline {
            try? await Task.sleep(for: .milliseconds(20))
        }
    }

    @Test
    func appearing_loadsTheAccounts() async throws {
        let model = StubAccountsListModel(result: .success(try ProductSummary.fixture()))
        let viewModel = AccountsListViewModel(model: model, configuration: AccountsJourney.Configuration())

        let window = show(viewModel)
        defer { window.isHidden = true }
        await wait { !viewModel.isLoading }

        #expect(viewModel.accounts.map(\.id) == ["current-1", "savings-1", "loan-1", "custom-1"])
        #expect(model.fetchCount == 1)
    }

    @Test
    func changingTheSearchText_filtersTheAccounts_afterTheDebounce() async throws {
        let model = StubAccountsListModel(result: .success(try ProductSummary.fixture()))
        let viewModel = AccountsListViewModel(model: model, configuration: AccountsJourney.Configuration())
        let window = show(viewModel)
        defer { window.isHidden = true }
        await wait { !viewModel.isLoading }

        viewModel.searchText = "loan"
        // Typing is debounced, nothing has been requested yet.
        #expect(model.fetchCount == 1)
        await wait { viewModel.accounts.count == 1 }

        #expect(viewModel.accounts.map(\.id) == ["loan-1"])
        #expect(model.fetchCount == 2)
    }

    @Test
    func appearing_tracksTheScreenView() async throws {
        let tracker = TrackerSpy()
        let model = StubAccountsListModel(result: .success(try ProductSummary.fixture()))
        let viewModel = AccountsListViewModel(model: model, configuration: AccountsJourney.Configuration(), tracker: tracker)

        let window = show(viewModel)
        defer { window.isHidden = true }
        await wait { tracker.screenViewNames.count == 1 }

        #expect(tracker.screenViewNames == ["accounts_list"])
    }
}

// MARK: - Strings

@Suite("AccountsList search strings")
struct AccountsListSearchStringsTests {

    @Test
    func searchStrings_areLocalised() {
        let strings = AccountsList.Strings()

        #expect(!strings.searchText().isEmpty)
        #expect(!strings.clearSearchText().isEmpty)
        #expect(strings.clearSearchText() != "labels.clearSearchText")
        #expect(strings.clearSearchText() != "accountsJourney.accountsList.labels.clearSearchText")
    }
}
