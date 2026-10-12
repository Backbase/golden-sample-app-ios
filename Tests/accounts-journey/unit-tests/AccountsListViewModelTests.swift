import ArrangementsClient2Gen2
import BackbaseObservability
import ClientCommonGen2
import Observation
import Testing
@testable import AccountsJourney

// MARK: - View model

@Suite("AccountsListViewModel")
@MainActor
struct AccountsListViewModelSwiftUITests {

    private struct SearchCase: CustomTestStringConvertible, Sendable {
        let name: String
        let query: String
        let expectedIDs: [String]

        var testDescription: String { name }
    }

    private func makeViewModel(
        result: Result<ProductSummary, ErrorResponse>,
        tracker: Tracker? = nil,
        didSelectProduct: @escaping (String) -> Void = { _ in }
    ) -> (viewModel: AccountsListViewModel, useCase: StubAccountsListUseCase) {
        let useCase = StubAccountsListUseCase(result: result)
        let viewModel = AccountsListViewModel(
            useCase: useCase,
            configuration: AccountsJourney.Configuration(),
            tracker: tracker,
            didSelectProduct: didSelectProduct
        )
        return (viewModel, useCase)
    }

    private func makeViewModel(tracker: Tracker? = nil) throws -> (viewModel: AccountsListViewModel, useCase: StubAccountsListUseCase) {
        makeViewModel(result: .success(try ProductSummary.fixture()), tracker: tracker)
    }

    private static let failure = Result<ProductSummary, ErrorResponse>.failure(.error(500, nil, AccountsList.Error.invalidResponse))

    // MARK: Loading

    @Test
    func initialState_isLoading() throws {
        let (viewModel, _) = try makeViewModel()

        #expect(viewModel.isLoading)
        #expect(viewModel.accounts.isEmpty)
        #expect(viewModel.error == nil)
        #expect(!viewModel.isEmpty)
    }

    @Test
    func loadedAccounts_areExposedAsUIModels() async throws {
        let (viewModel, _) = try makeViewModel()

        await viewModel.loadAccountsIfNeeded()

        #expect(viewModel.accounts.map(\.id) == ["current-1", "savings-1", "loan-1", "custom-1"])
        #expect(!viewModel.isLoading)
        #expect(viewModel.error == nil)
        #expect(!viewModel.isEmpty)
    }

    @Test
    func loadAccountsIfNeeded_loadsOnlyOnce() async throws {
        let (viewModel, useCase) = try makeViewModel()

        await viewModel.loadAccountsIfNeeded()
        await viewModel.loadAccountsIfNeeded()

        #expect(useCase.callCount == 1)
    }

    @Test
    func failedLoad_exposesTheError_andClearsTheAccounts() async throws {
        let (viewModel, useCase) = try makeViewModel()
        await viewModel.loadAccountsIfNeeded()
        #expect(!viewModel.accounts.isEmpty)

        useCase.result = Self.failure
        await viewModel.refresh()

        #expect(viewModel.accounts.isEmpty)
        #expect(!viewModel.isLoading)
        #expect(!viewModel.isEmpty)
        guard case .loadingFailure = viewModel.error else {
            Issue.record("Expected a loading failure, got \(String(describing: viewModel.error))")
            return
        }
    }

    // MARK: Refresh

    @Test
    func refresh_returnsOnlyOnceTheReloadHasFinished() async {
        let useCase = DelayedFailingUseCase()
        let viewModel = AccountsListViewModel(useCase: useCase, configuration: AccountsJourney.Configuration())

        await viewModel.refresh()

        #expect(useCase.callCount == 1)
        #expect(!viewModel.isLoading)
        #expect(viewModel.error != nil)
    }

    @Test
    func refresh_recoversFromAnError_andClearsTheSearch() async throws {
        let (viewModel, useCase) = makeViewModel(result: Self.failure)
        await viewModel.refresh()
        #expect(viewModel.error != nil)

        useCase.result = .success(try ProductSummary.fixture())
        viewModel.searchText = "loan"
        await viewModel.refresh()

        #expect(viewModel.error == nil)
        #expect(viewModel.searchText == "")
        #expect(viewModel.accounts.count == 4)
    }

    @Test
    func refresh_isNotTrackedAsAUserAction() async throws {
        let tracker = TrackerSpy()
        let (viewModel, _) = try makeViewModel(tracker: tracker)

        await viewModel.refresh()

        #expect(tracker.userActionNames.isEmpty)
    }

    @Test
    func pullToRefresh_tracksTheUserAction_andReloads() async throws {
        let tracker = TrackerSpy()
        let (viewModel, useCase) = try makeViewModel(tracker: tracker)

        await viewModel.pullToRefresh()

        #expect(tracker.userActionNames == ["refresh_accounts"])
        #expect(useCase.callCount == 1)
        #expect(viewModel.accounts.count == 4)
    }

    // MARK: Search

    @Test("submitSearch filters the accounts", arguments: [
        SearchCase(name: "matching accounts are kept", query: "loan", expectedIDs: ["loan-1"]),
        SearchCase(name: "no match leaves nothing", query: "xyz", expectedIDs: [])
    ])
    private func submitSearch_filtersTheAccounts(_ searchCase: SearchCase) async throws {
        let (viewModel, _) = try makeViewModel()

        viewModel.searchText = searchCase.query
        await viewModel.submitSearch(debounce: .zero)

        #expect(viewModel.accounts.map(\.id) == searchCase.expectedIDs)
        #expect(viewModel.isEmpty == searchCase.expectedIDs.isEmpty)
    }

    @Test
    func submitSearch_doesNotReloadTheSameQuery() async throws {
        let (viewModel, useCase) = try makeViewModel()

        viewModel.searchText = "loan"
        await viewModel.submitSearch(debounce: .zero)
        await viewModel.submitSearch(debounce: .zero)

        #expect(useCase.callCount == 1)
    }

    @Test
    func submitSearch_doesNothing_whenTheTextWasNeverChanged() async throws {
        let (viewModel, useCase) = try makeViewModel()

        await viewModel.submitSearch(debounce: .zero)

        #expect(useCase.callCount == 0)
    }

    @Test
    func submitSearch_isCancelledWhileDebouncing() async throws {
        let (viewModel, useCase) = try makeViewModel()
        viewModel.searchText = "loan"

        let search = Task { await viewModel.submitSearch(debounce: .seconds(30)) }
        search.cancel()
        await search.value

        #expect(useCase.callCount == 0)
    }

    @Test
    func failedSearch_clearsTheSearchText() async {
        let (viewModel, _) = makeViewModel(result: Self.failure)

        viewModel.searchText = "loan"
        await viewModel.submitSearch(debounce: .zero)

        #expect(viewModel.searchText == "")
        #expect(viewModel.error != nil)
    }

    // MARK: Routing and tracking

    @Test
    func select_routesToTheProduct() throws {
        var routedIDs = [String]()
        let (viewModel, _) = makeViewModel(
            result: .success(try ProductSummary.fixture()),
            didSelectProduct: { routedIDs.append($0) }
        )

        viewModel.select(accountID: "loan-1")

        #expect(routedIDs == ["loan-1"])
    }

    @Test
    func screenDidAppear_tracksTheScreenView_everyTime() throws {
        let tracker = TrackerSpy()
        let (viewModel, _) = try makeViewModel(tracker: tracker)

        viewModel.screenDidAppear()
        viewModel.screenDidAppear()

        #expect(tracker.screenViewNames == ["accounts_list", "accounts_list"])
    }

    // MARK: Observation

    @Test
    func stateChanges_areObservedBySwiftUI() async throws {
        let (viewModel, _) = try makeViewModel()

        await confirmation("the accounts change is observed") { changed in
            withObservationTracking {
                _ = viewModel.accounts
            } onChange: {
                changed()
            }

            await viewModel.loadAccountsIfNeeded()
        }
    }
}
