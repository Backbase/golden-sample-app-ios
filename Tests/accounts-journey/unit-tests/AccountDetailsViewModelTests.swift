import ArrangementsClient2Gen2
import BackbaseObservability
import ClientCommonGen2
import Resolver
import SwiftUI
import Testing
import UIKit
@testable import AccountsJourney

private let failure = Result<AccountArrangementItem, ErrorResponse>.failure(.error(500, nil, AccountDetails.Error.invalidResponse))

/// Lets the main actor run until `condition` holds.
@MainActor
private func wait(timeout: Duration = .seconds(5), until condition: () -> Bool) async {
    let deadline = ContinuousClock.now + timeout
    while !condition(), ContinuousClock.now < deadline {
        try? await Task.sleep(for: .milliseconds(20))
    }
}

// MARK: - View model

@Suite("AccountDetailsViewModel", .timeLimit(.minutes(1)))
@MainActor
struct AccountDetailsViewModelTests {

    private func makeViewModel(
        result: Result<AccountArrangementItem, ErrorResponse>,
        arrangementId: String = "arrangement-1",
        tracker: Tracker? = nil
    ) -> (viewModel: AccountDetailsViewModel, useCase: StubAccountDetailsUseCase) {
        let useCase = StubAccountDetailsUseCase(result: result)
        let viewModel = AccountDetailsViewModel(
            arrangementId: arrangementId,
            useCase: useCase,
            configuration: AccountsJourney.Configuration(),
            tracker: tracker
        )
        return (viewModel, useCase)
    }

    private func makeViewModel(tracker: Tracker? = nil) throws -> (viewModel: AccountDetailsViewModel, useCase: StubAccountDetailsUseCase) {
        makeViewModel(result: .success(try .fixture()), tracker: tracker)
    }

    // MARK: Loading

    @Test
    func initialState_isLoading() throws {
        let (viewModel, useCase) = try makeViewModel()

        #expect(viewModel.isLoading)
        #expect(viewModel.details == nil)
        #expect(viewModel.error == nil)
        #expect(useCase.requestedIds.isEmpty)
    }

    @Test
    func loadedDetails_areExposedAsAUIModel() async throws {
        let (viewModel, useCase) = try makeViewModel()

        await viewModel.loadIfNeeded()

        #expect(useCase.requestedIds == ["arrangement-1"])
        #expect(!viewModel.isLoading)
        #expect(viewModel.error == nil)
        let details = try #require(viewModel.details)
        #expect(details.id == "arrangement-1")
        #expect(details.displayName == "John Doe")
        #expect(details.BBAN == "NL91ABNA0417164300")
        #expect(details.availableBalance == 3207.61)
        #expect(details.creditLimit == 1055.5)
        #expect(details.accountState == "Active")
    }

    @Test
    func loadIfNeeded_loadsOnlyOnce() async throws {
        let (viewModel, useCase) = try makeViewModel()

        await viewModel.loadIfNeeded()
        await viewModel.loadIfNeeded()

        #expect(useCase.requestedIds.count == 1)
    }

    @Test
    func load_requestsTheAccountOfTheViewModel() async throws {
        let (viewModel, useCase) = makeViewModel(result: .success(try .fixture()), arrangementId: "other-arrangement")

        await viewModel.load()

        #expect(useCase.requestedIds == ["other-arrangement"])
    }

    @Test
    func failedLoad_exposesTheError_andHasNoDetails() async {
        let (viewModel, _) = makeViewModel(result: failure)

        await viewModel.loadIfNeeded()

        #expect(viewModel.details == nil)
        #expect(!viewModel.isLoading)
        guard case .loadingFailure = viewModel.error else {
            Issue.record("Expected a loading failure, got \(String(describing: viewModel.error))")
            return
        }
    }

    @Test
    func retry_recoversFromAnError() async throws {
        let (viewModel, useCase) = makeViewModel(result: failure)
        await viewModel.loadIfNeeded()
        #expect(viewModel.error != nil)

        useCase.result = .success(try .fixture())
        await viewModel.load()

        #expect(useCase.requestedIds == ["arrangement-1", "arrangement-1"])
        #expect(viewModel.error == nil)
        #expect(viewModel.details != nil)
    }

    @Test
    func failedReload_clearsTheDetails() async throws {
        let (viewModel, useCase) = try makeViewModel()
        await viewModel.loadIfNeeded()
        #expect(viewModel.details != nil)

        useCase.result = failure
        await viewModel.load()

        #expect(viewModel.details == nil)
        #expect(viewModel.error != nil)
    }

    // MARK: Overlapping loads

    @Test
    func isLoading_untilTheUseCaseAnswers() async throws {
        let useCase = DeferredAccountDetailsUseCase()
        let viewModel = AccountDetailsViewModel(
            arrangementId: "arrangement-1",
            useCase: useCase,
            configuration: AccountsJourney.Configuration()
        )

        let load = Task { await viewModel.load() }
        await wait { useCase.requestCount == 1 }
        #expect(viewModel.isLoading)
        #expect(viewModel.details == nil)

        useCase.complete(request: 0, with: .success(try .fixture()))
        await load.value

        #expect(!viewModel.isLoading)
        #expect(viewModel.details != nil)
    }

    @Test
    func answerOfASupersededLoad_isDropped() async throws {
        let useCase = DeferredAccountDetailsUseCase()
        let viewModel = AccountDetailsViewModel(
            arrangementId: "arrangement-1",
            useCase: useCase,
            configuration: AccountsJourney.Configuration()
        )
        let first = Task { await viewModel.load() }
        await wait { useCase.requestCount == 1 }
        let second = Task { await viewModel.load() }
        await wait { useCase.requestCount == 2 }

        useCase.complete(request: 1, with: .success(try .fixture()))
        await second.value
        // The first load answers last, with an error that must not replace the newer result.
        useCase.complete(request: 0, with: failure)
        await first.value

        #expect(viewModel.error == nil)
        #expect(viewModel.details != nil)
        #expect(!viewModel.isLoading)
    }

    // MARK: Tracking

    @Test
    func screenDidAppear_tracksTheScreenView() throws {
        let tracker = TrackerSpy()
        let (viewModel, _) = try makeViewModel(tracker: tracker)

        viewModel.screenDidAppear()

        #expect(tracker.screenViewNames == ["account_details"])
    }

    @Test
    func screenDidAppear_tracksEveryAppearance() throws {
        let tracker = TrackerSpy()
        let (viewModel, _) = try makeViewModel(tracker: tracker)

        viewModel.screenDidAppear()
        viewModel.screenDidAppear()

        #expect(tracker.screenViewNames.count == 2)
    }

    @Test
    func screenDidAppear_withoutATracker_doesNothing() throws {
        let (viewModel, _) = try makeViewModel()

        viewModel.screenDidAppear()

        #expect(viewModel.isLoading)
    }
}

// MARK: - Error state

@Suite("AccountDetails.Error state view configuration")
struct AccountDetailsErrorStateViewConfigurationTests {

    private let journeyConfiguration = AccountsJourney.Configuration()

    @Test("Errors can be retried", arguments: [
        AccountDetails.Error.loadingFailure(),
        .notConnected,
        .invalidResponse
    ])
    func error_offersToRetry(error: AccountDetails.Error) throws {
        var retries = 0

        let configuration = error.stateViewConfiguration(configuration: journeyConfiguration) { retries += 1 }

        let button = try #require(configuration.firstButtonConfiguration)
        button.action()
        #expect(retries == 1)
    }

    @Test
    func texts_comeFromTheGivenConfiguration() {
        var journeyConfiguration = AccountsJourney.Configuration()
        journeyConfiguration.accountDetails.strings.errorTitle = { _ in "Custom title" }

        let configuration = AccountDetails.Error.loadingFailure().stateViewConfiguration(configuration: journeyConfiguration) {}

        #expect(configuration.title == "Custom title")
    }
}

// MARK: - View

/// `AccountDetailsView` hosted in a window, to check that SwiftUI drives the view model:
/// `.task` loads the account and `onAppear` tracks the screen view.
@Suite("AccountDetailsView", .timeLimit(.minutes(1)))
@MainActor
struct AccountDetailsViewTests {

    /// Keeps the window visible, which is what makes SwiftUI run the view's tasks.
    private func show(_ viewModel: AccountDetailsViewModel) -> UIWindow {
        let rootView = NavigationStack { AccountDetailsView(viewModel: viewModel, configuration: AccountsJourney.Configuration()) }
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 390, height: 844))
        window.rootViewController = UIHostingController(rootView: rootView)
        window.makeKeyAndVisible()
        return window
    }

    @Test
    func appearing_loadsTheAccount() async throws {
        let useCase = StubAccountDetailsUseCase(result: .success(try .fixture()))
        let viewModel = AccountDetailsViewModel(
            arrangementId: "arrangement-1",
            useCase: useCase,
            configuration: AccountsJourney.Configuration()
        )

        let window = show(viewModel)
        defer { window.isHidden = true }
        await wait { !viewModel.isLoading }

        #expect(viewModel.details?.id == "arrangement-1")
        #expect(useCase.requestedIds == ["arrangement-1"])
    }

    @Test
    func appearing_tracksTheScreenView() async throws {
        let tracker = TrackerSpy()
        let useCase = StubAccountDetailsUseCase(result: .success(try .fixture()))
        let viewModel = AccountDetailsViewModel(
            arrangementId: "arrangement-1",
            useCase: useCase,
            configuration: AccountsJourney.Configuration(),
            tracker: tracker
        )

        let window = show(viewModel)
        defer { window.isHidden = true }
        await wait { tracker.screenViewNames.count == 1 }

        #expect(tracker.screenViewNames == ["account_details"])
    }
}

// MARK: - Entry point

/// `AccountDetails.build(navigationController:arrangementId:)`, the entry point of the screen. It is the
/// composition root, so it resolves its dependencies from the global `Resolver`: the suite is serialized.
@Suite("AccountDetails.build", .serialized)
@MainActor
struct AccountDetailsBuildTests {

    private func register() throws {
        let useCase = StubAccountDetailsUseCase(result: .success(try .fixture()))
        let configuration = AccountsJourney.Configuration()
        Resolver.register { useCase as AccountDetailsUseCase }
        Resolver.register { configuration }
    }

    @Test
    func build_returnsAHostingControllerForTheSwiftUIScreen() throws {
        try register()

        let viewController = AccountDetails.build(navigationController: UINavigationController(), arrangementId: "1")

        #expect(viewController is UIHostingController<AccountDetailsView>)
    }

    @Test
    func selectingAnAccount_withTheDefaultRouter_pushesTheSwiftUIAccountDetails() throws {
        try register()
        let navigationController = UINavigationController()
        let configuration = AccountsJourney.Configuration()

        configuration.accountsList.router.didSelectProduct(navigationController)("arrangement-1")

        #expect(navigationController.viewControllers.count == 1)
        #expect(navigationController.topViewController is UIHostingController<AccountDetailsView>)
    }
}
