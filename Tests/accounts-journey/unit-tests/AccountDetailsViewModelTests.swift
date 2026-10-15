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
        tracker: Tracker? = nil,
        contentMapper: AccountDetailsContentMapper? = nil
    ) -> (viewModel: AccountDetailsViewModel, model: StubAccountDetailsModel) {
        let model = StubAccountDetailsModel(result: result)
        let viewModel = AccountDetailsViewModel(
            model: model,
            configuration: AccountsJourney.Configuration(),
            tracker: tracker,
            contentMapper: contentMapper
        )
        return (viewModel, model)
    }

    private func makeViewModel(tracker: Tracker? = nil) throws -> (viewModel: AccountDetailsViewModel, model: StubAccountDetailsModel) {
        makeViewModel(result: .success(try .fixture()), tracker: tracker)
    }

    // MARK: Loading

    @Test
    func initialState_isLoading() throws {
        let (viewModel, model) = try makeViewModel()

        #expect(viewModel.isLoading)
        #expect(viewModel.details == nil)
        #expect(viewModel.error == nil)
        #expect(model.fetchCount == 0)
    }

    @Test
    func loadedDetails_areExposedAsAccountDetailsData() async throws {
        let (viewModel, model) = try makeViewModel()

        await viewModel.loadIfNeeded()

        #expect(model.fetchCount == 1)
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

    // MARK: Content

    @Test
    func initialState_hasNoContent() throws {
        let (viewModel, _) = try makeViewModel()

        #expect(viewModel.content == nil)
    }

    @Test
    func content_isTheMappersOutputForTheLoadedDetails() async throws {
        let mapper = AccountDetailsContentMapper(
            strings: AccountsJourney.Configuration().accountDetails.strings,
            formatAmount: { amount, currency in "\(amount) \(currency)!" }
        )
        let (viewModel, _) = makeViewModel(result: .success(try .fixture()), contentMapper: mapper)

        await viewModel.loadIfNeeded()

        let details = try #require(viewModel.details)
        #expect(viewModel.content == mapper.content(for: details))
        #expect(viewModel.content?.header.balance == "3207.61 EUR!")
    }

    @Test
    func failedReload_clearsTheContent() async throws {
        let (viewModel, model) = try makeViewModel()
        await viewModel.loadIfNeeded()
        #expect(viewModel.content != nil)

        model.result = failure
        await viewModel.load()

        #expect(viewModel.content == nil)
    }

    @Test
    func loadIfNeeded_loadsOnlyOnce() async throws {
        let (viewModel, model) = try makeViewModel()

        await viewModel.loadIfNeeded()
        await viewModel.loadIfNeeded()

        #expect(model.fetchCount == 1)
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
        let (viewModel, model) = makeViewModel(result: failure)
        await viewModel.loadIfNeeded()
        #expect(viewModel.error != nil)

        model.result = .success(try .fixture())
        await viewModel.load()

        #expect(model.fetchCount == 2)
        #expect(viewModel.error == nil)
        #expect(viewModel.details != nil)
    }

    @Test
    func failedReload_clearsTheDetails() async throws {
        let (viewModel, model) = try makeViewModel()
        await viewModel.loadIfNeeded()
        #expect(viewModel.details != nil)

        model.result = failure
        await viewModel.load()

        #expect(viewModel.details == nil)
        #expect(viewModel.error != nil)
    }

    // MARK: Overlapping loads

    @Test
    func isLoading_untilTheModelAnswers() async throws {
        let model = DeferredAccountDetailsModel()
        let viewModel = AccountDetailsViewModel(model: model, configuration: AccountsJourney.Configuration())

        let load = Task { await viewModel.load() }
        await wait { model.requestCount == 1 }
        #expect(viewModel.isLoading)
        #expect(viewModel.details == nil)

        model.complete(request: 0, with: .success(try .fixture()))
        await load.value

        #expect(!viewModel.isLoading)
        #expect(viewModel.details != nil)
    }

    @Test
    func answerOfASupersededLoad_isDropped() async throws {
        let model = DeferredAccountDetailsModel()
        let viewModel = AccountDetailsViewModel(model: model, configuration: AccountsJourney.Configuration())
        let first = Task { await viewModel.load() }
        await wait { model.requestCount == 1 }
        let second = Task { await viewModel.load() }
        await wait { model.requestCount == 2 }

        model.complete(request: 1, with: .success(try .fixture()))
        await second.value
        // The first load answers last, with an error that must not replace the newer result.
        model.complete(request: 0, with: failure)
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

        let configuration = error.stateViewConfiguration(using: journeyConfiguration) { retries += 1 }

        let button = try #require(configuration.firstButtonConfiguration)
        button.action()
        #expect(retries == 1)
    }

    @Test
    func texts_comeFromTheGivenConfiguration() {
        var journeyConfiguration = AccountsJourney.Configuration()
        journeyConfiguration.accountDetails.strings.errorTitle = { _ in "Custom title" }

        let configuration = AccountDetails.Error.loadingFailure().stateViewConfiguration(using: journeyConfiguration) {}

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
        let model = StubAccountDetailsModel(result: .success(try .fixture()))
        let viewModel = AccountDetailsViewModel(model: model, configuration: AccountsJourney.Configuration())

        let window = show(viewModel)
        defer { window.isHidden = true }
        await wait { !viewModel.isLoading }

        #expect(viewModel.details?.id == "arrangement-1")
        #expect(model.fetchCount == 1)
    }

    @Test
    func appearing_tracksTheScreenView() async throws {
        let tracker = TrackerSpy()
        let model = StubAccountDetailsModel(result: .success(try .fixture()))
        let viewModel = AccountDetailsViewModel(
            model: model,
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

        #expect(viewController is UIHostingController<AccountDetailsView<AccountDetailsViewModel>>)
    }

    @Test
    func selectingAnAccount_withTheDefaultRouter_pushesTheSwiftUIAccountDetails() throws {
        try register()
        let navigationController = UINavigationController()
        let configuration = AccountsJourney.Configuration()

        configuration.accountsList.router.didSelectProduct(navigationController)("arrangement-1")

        #expect(navigationController.viewControllers.count == 1)
        #expect(navigationController.topViewController is UIHostingController<AccountDetailsView<AccountDetailsViewModel>>)
    }
}
