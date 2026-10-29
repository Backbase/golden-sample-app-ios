import ArrangementsClient2Gen2
import BackbaseObservability
import ClientCommonGen2
import Observation
import Testing
@testable import AccountsJourney

/// Lets the main actor run until `condition` holds.
@MainActor
private func wait(timeout: Duration = .seconds(5), until condition: () -> Bool) async {
    let deadline = ContinuousClock.now + timeout
    while !condition(), ContinuousClock.now < deadline {
        try? await Task.sleep(for: .milliseconds(20))
    }
}

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
        contentMapper: AccountsListContentMapper? = nil
    ) -> (viewModel: AccountsListViewModel, model: StubAccountsListModel) {
        let model = StubAccountsListModel(result: result)
        let viewModel = AccountsListViewModel(
            model: model,
            configuration: AccountsJourney.Configuration(),
            tracker: tracker,
            contentMapper: contentMapper
        )
        return (viewModel, model)
    }

    private func makeViewModel(tracker: Tracker? = nil) throws -> (viewModel: AccountsListViewModel, model: StubAccountsListModel) {
        makeViewModel(result: .success(try ProductSummary.fixture()), tracker: tracker)
    }

    private static let failure = Result<ProductSummary, ErrorResponse>.failure(.error(500, nil, AccountsList.Error.invalidResponse))

    // MARK: Loading

    @Test
    func initialState_isLoading() throws {
        let (viewModel, _) = try makeViewModel()

        #expect(viewModel.state.isLoading)
        #expect(viewModel.accounts.isEmpty)
        #expect(!viewModel.isEmpty)
    }

    @Test
    func loadedAccounts_areExposedAsAccountData() async throws {
        let (viewModel, _) = try makeViewModel()

        await viewModel.loadAccountsIfNeeded()

        #expect(viewModel.accounts.map(\.id) == ["current-1", "savings-1", "loan-1", "custom-1"])
        #expect(!viewModel.state.isLoading)
        #expect(viewModel.state.errorConfiguration == nil)
        #expect(viewModel.state.data?.isReloading == false)
        #expect(!viewModel.isEmpty)
    }

    @Test
    func rows_areTheMappersOutputForTheLoadedAccounts() async throws {
        let mapper = AccountsListContentMapper(
            strings: AccountsJourney.Configuration().accountsList.strings,
            formatAmount: { "\($0.amount) \($0.currencyCode)!" }
        )
        let (viewModel, _) = makeViewModel(result: .success(try ProductSummary.fixture()), contentMapper: mapper)

        await viewModel.loadAccountsIfNeeded()

        #expect(viewModel.state.data?.rows == mapper.rows(for: viewModel.accounts))
        #expect(viewModel.state.data?.rows.map(\.id) == ["current-1", "savings-1", "loan-1", "custom-1"])
    }

    @Test
    func loadAccountsIfNeeded_loadsOnlyOnce() async throws {
        let (viewModel, model) = try makeViewModel()

        await viewModel.loadAccountsIfNeeded()
        await viewModel.loadAccountsIfNeeded()

        #expect(model.fetchCount == 1)
    }

    @Test
    func failedLoad_exposesTheError_andClearsTheAccounts() async throws {
        let (viewModel, model) = try makeViewModel()
        await viewModel.loadAccountsIfNeeded()
        #expect(!viewModel.accounts.isEmpty)

        model.result = Self.failure
        await viewModel.refresh()

        #expect(viewModel.accounts.isEmpty)
        #expect(viewModel.state.data == nil)
        #expect(!viewModel.state.isLoading)
        #expect(!viewModel.isEmpty)
        #expect(viewModel.state.errorConfiguration != nil)
    }

    @Test
    func errorTexts_comeFromTheJourneyConfiguration() async {
        let (viewModel, _) = makeViewModel(result: Self.failure)
        let expected = AccountsJourney.Configuration().accountsList.strings.errorTitle(.loadingFailure())()

        await viewModel.refresh()

        #expect(viewModel.state.errorConfiguration?.title == expected)
    }

    @Test
    func errorState_isTheErrorMappersOutput() async {
        var configuration = AccountsJourney.Configuration()
        configuration.accountsList.strings.errorTitle = { _ in "Mapped title" }
        let viewModel = AccountsListViewModel(
            model: StubAccountsListModel(result: Self.failure),
            configuration: configuration,
            errorMapper: AccountsListErrorConfigurationMapper(journeyConfiguration: configuration)
        )

        await viewModel.refresh()

        #expect(viewModel.state.errorConfiguration?.title == "Mapped title")
    }

    @Test
    func retry_recoversFromAnError() async throws {
        let (viewModel, model) = makeViewModel(result: Self.failure)
        await viewModel.refresh()
        let retry = try #require(viewModel.state.errorConfiguration?.firstButtonConfiguration)

        model.result = .success(try ProductSummary.fixture())
        retry.action()
        await wait { viewModel.state.data != nil }

        #expect(model.fetchCount == 2)
        #expect(viewModel.state.data?.rows.count == 4)
        #expect(viewModel.state.errorConfiguration == nil)
    }

    // MARK: Reloading

    @Test
    func firstLoad_showsTheSpinner_untilTheModelAnswers() async throws {
        let model = DeferredAccountsListModel()
        let viewModel = AccountsListViewModel(model: model, configuration: AccountsJourney.Configuration())

        let load = Task { await viewModel.refresh() }
        await wait { model.requestCount == 1 }
        #expect(viewModel.state.isLoading)

        model.complete(request: 0, with: .success(try ProductSummary.fixture()))
        await load.value

        #expect(viewModel.state.data?.rows.count == 4)
    }

    @Test
    func reload_keepsTheRowsOnScreen_untilTheModelAnswers() async throws {
        let model = DeferredAccountsListModel()
        let viewModel = AccountsListViewModel(model: model, configuration: AccountsJourney.Configuration())
        let first = Task { await viewModel.refresh() }
        await wait { model.requestCount == 1 }
        model.complete(request: 0, with: .success(try ProductSummary.fixture()))
        await first.value

        let reload = Task { await viewModel.refresh() }
        await wait { model.requestCount == 2 }

        #expect(viewModel.state.data?.rows.count == 4)
        #expect(viewModel.state.data?.isReloading == true)
        #expect(!viewModel.isEmpty)

        model.complete(request: 1, with: .success(try ProductSummary.fixture()))
        await reload.value

        #expect(viewModel.state.data?.isReloading == false)
    }

    @Test
    func retryAfterAnError_showsTheSpinner() async throws {
        let model = DeferredAccountsListModel()
        let viewModel = AccountsListViewModel(model: model, configuration: AccountsJourney.Configuration())
        let first = Task { await viewModel.refresh() }
        await wait { model.requestCount == 1 }
        model.complete(request: 0, with: Self.failure)
        await first.value
        #expect(viewModel.state.errorConfiguration != nil)

        let retry = Task { await viewModel.refresh() }
        await wait { model.requestCount == 2 }

        #expect(viewModel.state.isLoading)
        model.complete(request: 1, with: .success(try ProductSummary.fixture()))
        await retry.value
    }

    @Test
    func answerOfASupersededLoad_isDropped() async throws {
        let model = DeferredAccountsListModel()
        let viewModel = AccountsListViewModel(model: model, configuration: AccountsJourney.Configuration())
        let first = Task { await viewModel.refresh() }
        await wait { model.requestCount == 1 }
        let second = Task { await viewModel.refresh() }
        await wait { model.requestCount == 2 }

        model.complete(request: 1, with: .success(try ProductSummary.fixture()))
        await second.value
        // The first load answers last, with an error that must not replace the newer result.
        model.complete(request: 0, with: Self.failure)
        await first.value

        #expect(viewModel.state.errorConfiguration == nil)
        #expect(viewModel.state.data?.rows.count == 4)
    }

    // MARK: Refresh

    @Test
    func refresh_returnsOnlyOnceTheReloadHasFinished() async {
        let model = DelayedFailingAccountsListModel()
        let viewModel = AccountsListViewModel(model: model, configuration: AccountsJourney.Configuration())

        await viewModel.refresh()

        #expect(model.fetchCount == 1)
        #expect(!viewModel.state.isLoading)
        #expect(viewModel.state.errorConfiguration != nil)
    }

    @Test
    func refresh_recoversFromAnError_andClearsTheSearch() async throws {
        let (viewModel, model) = makeViewModel(result: Self.failure)
        await viewModel.refresh()
        #expect(viewModel.state.errorConfiguration != nil)

        model.result = .success(try ProductSummary.fixture())
        viewModel.searchText = "loan"
        await viewModel.refresh()

        #expect(viewModel.state.errorConfiguration == nil)
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
        let (viewModel, model) = try makeViewModel(tracker: tracker)

        await viewModel.pullToRefresh()

        #expect(tracker.userActionNames == ["refresh_accounts"])
        #expect(model.fetchCount == 1)
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

    @Test("filter keeps the accounts whose name contains the query", arguments: [
        SearchCase(name: "ignores case and surrounding whitespace", query: "  SAV ", expectedIDs: ["savings"]),
        // "a" is in "Main", "Savings" and "Car loan", not in "Custom"; the unnamed account never matches.
        SearchCase(name: "skips accounts without a name", query: "a", expectedIDs: ["current", "savings", "loan"]),
        SearchCase(name: "is empty when nothing matches", query: "xyz", expectedIDs: []),
        SearchCase(name: "keeps everything for an empty query", query: "", expectedIDs: ["current", "savings", "loan", "unnamed", "custom"]),
        SearchCase(name: "keeps everything for a blank query", query: "   ", expectedIDs: ["current", "savings", "loan", "unnamed", "custom"])
    ])
    private func filter_matchesTheName(_ searchCase: SearchCase) {
        let accounts = [
            AccountData(id: "current", name: "Main"),
            AccountData(id: "savings", name: "Savings"),
            AccountData(id: "loan", name: "Car loan"),
            AccountData(id: "unnamed", name: nil),
            AccountData(id: "custom", name: "Custom")
        ]

        #expect(AccountsListViewModel.filter(accounts, by: searchCase.query).map(\.id) == searchCase.expectedIDs)
    }

    @Test
    func submitSearch_doesNotReloadTheSameQuery() async throws {
        let (viewModel, model) = try makeViewModel()

        viewModel.searchText = "loan"
        await viewModel.submitSearch(debounce: .zero)
        await viewModel.submitSearch(debounce: .zero)

        #expect(model.fetchCount == 1)
    }

    @Test
    func submitSearch_filtersLocally_withoutRefetchingAfterInitialLoad() async throws {
        let (viewModel, model) = try makeViewModel()

        await viewModel.loadAccountsIfNeeded()
        #expect(model.fetchCount == 1)

        viewModel.searchText = "loan"
        await viewModel.submitSearch(debounce: .zero)

        #expect(model.fetchCount == 1)
        #expect(viewModel.accounts.map(\.id) == ["loan-1"])
    }

    @Test
    func submitSearch_doesNothing_whenTheTextWasNeverChanged() async throws {
        let (viewModel, model) = try makeViewModel()

        await viewModel.submitSearch(debounce: .zero)

        #expect(model.fetchCount == 0)
    }

    @Test
    func submitSearch_isCancelledWhileDebouncing() async throws {
        let (viewModel, model) = try makeViewModel()
        viewModel.searchText = "loan"

        let search = Task { await viewModel.submitSearch(debounce: .seconds(30)) }
        search.cancel()
        await search.value

        #expect(model.fetchCount == 0)
    }

    @Test
    func failedSearch_clearsTheSearchText() async {
        let (viewModel, _) = makeViewModel(result: Self.failure)

        viewModel.searchText = "loan"
        await viewModel.submitSearch(debounce: .zero)

        #expect(viewModel.searchText == "")
        #expect(viewModel.state.errorConfiguration != nil)
    }

    // MARK: Routing and tracking

    @Test
    func select_asksTheModelToNavigateToTheProduct() throws {
        let (viewModel, model) = try makeViewModel()

        viewModel.select(accountID: "loan-1")

        #expect(model.navigatedAccountIDs == ["loan-1"])
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

        await confirmation("the state change is observed") { changed in
            withObservationTracking {
                _ = viewModel.state
            } onChange: {
                changed()
            }

            await viewModel.loadAccountsIfNeeded()
        }
    }
}
