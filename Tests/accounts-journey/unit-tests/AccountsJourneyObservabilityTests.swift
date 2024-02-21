import XCTest
import Combine
import Resolver
import BackbaseObservability
@testable import AccountsJourney

final class AccountsJourneyObservabilityTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        let accountsJourneyConfig = AccountsJourney.Configuration()
        Resolver.register { accountsJourneyConfig }
        Resolver.register { DummyAccountsListUseCase() as AccountsListUseCase }
        Resolver.register { DummyAccountDetailsUseCase() as AccountDetailsUseCase }
    }
    
    //MARK: -  AccountsList Events
    
    func test_accountsScreenEventIsPublished_whenTheAccountsViewLoads() {
        let screenViewEventsSpy = TrackerSpy<ScreenViewEvent>()
        Resolver.register { screenViewEventsSpy as Tracker }
        
        let viewDidAppearSubject = PassthroughSubject<Void, Never>()
        let userActionEventSubject = PassthroughSubject<UserActionEvent, Never>()
        let viewModel = AccountsListViewModel()
        
        viewModel.bind(
            viewDidAppearPublisher: viewDidAppearSubject.eraseToAnyPublisher(),
            userActionEventPublisher: userActionEventSubject.eraseToAnyPublisher()
        )
        
        // No event has been triggered yet. List of events should be empty
        XCTAssertEqual(screenViewEventsSpy.publishedEvents, [])
        
        viewDidAppearSubject.send()
        
        XCTAssertEqual(screenViewEventsSpy.publishedEvents.count, 1)
        XCTAssertEqual(screenViewEventsSpy.publishedEvents.first??.journey, "accounts_transactions")
        XCTAssertEqual(screenViewEventsSpy.publishedEvents.first??.name, "accounts_list")
    }
    
    func test_refresh_accountsUserActionEvent_isPublished_whenTheRefreshEventIsEmitted() {
        let userActionSpy = TrackerSpy<UserActionEvent>()
        
        Resolver.register { userActionSpy as Tracker }
        
        let viewDidAppearSubject = PassthroughSubject<Void, Never>()
        let userActionEventSubject = PassthroughSubject<UserActionEvent, Never>()
        let viewModel = AccountsListViewModel()
        
        viewModel.bind(
            viewDidAppearPublisher: viewDidAppearSubject.eraseToAnyPublisher(),
            userActionEventPublisher: userActionEventSubject.eraseToAnyPublisher()
        )
        
        // No event has been triggered yet. List of events should be empty
        XCTAssertEqual(userActionSpy.publishedEvents, [])
        
        userActionEventSubject.send(UserActionEvent(.refreshAccounts))
        
        XCTAssertEqual(userActionSpy.publishedEvents.count, 1)
        XCTAssertEqual(userActionSpy.publishedEvents.first??.journey, "accounts_transactions")
        XCTAssertEqual(userActionSpy.publishedEvents.first??.name, "refresh_accounts")
    }
    

    // MARK: - AccountDetails Tests
    
    func test_accountsDetailsScreenEventIsPublished_whenTheAccountsDetailsViewLoads() {
        let screenViewEventsSpy = TrackerSpy<ScreenViewEvent>()
        Resolver.register { screenViewEventsSpy as Tracker }
        
        let valueSubject = PassthroughSubject<Void, Never>()
        let viewModel = AccountDetailsViewModel()
        viewModel.bind(viewDidAppear: valueSubject.eraseToAnyPublisher())
        
        // No event has been triggered yet. List of events should be empty
        XCTAssertEqual(screenViewEventsSpy.publishedEvents, [])
        
        valueSubject.send()
        
        XCTAssertEqual(screenViewEventsSpy.publishedEvents.count, 1)
        XCTAssertEqual(screenViewEventsSpy.publishedEvents.first??.journey, "accounts_transactions")
        XCTAssertEqual(screenViewEventsSpy.publishedEvents.first??.name, "account_details")
    }
    
    // MARK: - Private
    
    private class TrackerSpy<S>: NSObject, Tracker {
        private(set) var publishedEvents = [S?]()
        
        func publish<T>(event: T) {
            publishedEvents.append(event as? S)
        }
        
        func subscribe<T>(subscriber: AnyHashable, eventClass: T.Type, completion: @escaping (T) -> Void) {}
        func unsubscribe(subscriber: AnyHashable) {}
    }
    
}
extension ScreenViewEvent: Equatable {
    public static func == (lhs: ScreenViewEvent, rhs: ScreenViewEvent) -> Bool {
        (lhs.name == rhs.name) && (lhs.journey == rhs.journey)
    }
}

private final class DummyAccountsListUseCase: AccountsListUseCase {
    func getAccountSummary(_ completion: @escaping (Result<AccountsJourney.AccountsSummary, AccountsJourney.ErrorResponse>) -> Void) {}
}

private final class DummyAccountDetailsUseCase: AccountDetailsUseCase {
    func getAccountDetail(arrangementId: String, _ completion: @escaping (Result<AccountsJourney.AccountDetailsModel, AccountsJourney.ErrorResponse>) -> Void) {}
}
