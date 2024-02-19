import XCTest
import Resolver
import BackbaseObservability
@testable import AccountsJourney

final class AccountsJourneyObservabilityTests: XCTestCase {
    
    private var userActionSpy: TrackerSpy<UserActionEvent>?
    private var screenViewEventsSpy: TrackerSpy<ScreenViewEvent>?
    
    override func setUp() {
        super.setUp()
        let accountsJourneyConfig = AccountsJourney.Configuration()
        Resolver.register { accountsJourneyConfig }
        Resolver.register { DummyAccountsListUseCase() as AccountsListUseCase }
        Resolver.register { DummyAccountDetailsUseCase() as AccountDetailsUseCase }
    }
    
    override func tearDown() {
        super.tearDown()
        userActionSpy = nil
        screenViewEventsSpy = nil
    }
    
    //MARK: -  AccountsList Events
    
    func test_noUserActionEventIsPublished_whenAccountsListViewModel_is_initialized() {
        userActionSpy = TrackerSpy<UserActionEvent>()
        expect(userActionSpy!, toReceive: [], when: {
            _ = AccountsListViewModel()
        })
    }
    
    func test_noScreenViewEventIsPublished_whenAccountListViewModel_is_initialized() {
        screenViewEventsSpy = TrackerSpy<ScreenViewEvent>()
        expect(screenViewEventsSpy!, toReceive: [], when: {
            _ = AccountsListViewModel()
        })
    }
    
    func test_accountsScreenEventIsPublished_whenTheAccountsViewLoads() {
        screenViewEventsSpy = TrackerSpy<ScreenViewEvent>()
        
        expect(screenViewEventsSpy!, toReceive: [ScreenViewEvent(.accounts_list)], when: {
            AccountsListViewModel().onEvent(.getAccounts)
        })
    }
    
    func test_refresh_accountsUserActionEvent_isPublished_whenTheRefreshEventIsEmitted() {
        userActionSpy = TrackerSpy<UserActionEvent>()
        
        expect(userActionSpy!, toReceive: [UserActionEvent(.refresh_accounts)], when: {
            AccountsListViewModel().onEvent(.refresh)
        })
    }
    
    func test_search_accountsUserActionEvent_isPublished_whenTheSearchEventIsEmitted() {
        userActionSpy = TrackerSpy<UserActionEvent>()
        
        expect(userActionSpy!, toReceive: [UserActionEvent(.search_accounts)], when: {
            AccountsListViewModel().onEvent(.search(""))
        })
    }
    
    
    // MARK: - AccountDetails Tests
    func test_noUserActionEventIsPublished_whenAccountDetailsViewModel_is_initialized() {
        userActionSpy = TrackerSpy<UserActionEvent>()
        expect(userActionSpy!, toReceive: [], when: {
            _ = AccountDetailsViewModel()
        })
    }
    
    func test_noScreenViewEventIsPublished_whenAccountDetailsViewModel_is_initialized() {
        screenViewEventsSpy = TrackerSpy<ScreenViewEvent>()
        expect(screenViewEventsSpy!, toReceive: [], when: {
            _ = AccountDetailsViewModel()
        })
    }
    
    func test_accountsDetailsScreenEventIsPublished_whenTheAccountsDetailsViewLoads() {
        screenViewEventsSpy = TrackerSpy<ScreenViewEvent>()

        expect(screenViewEventsSpy!, toReceive: [ScreenViewEvent(.account_details)], when: {
            AccountDetailsViewModel().onEvent(.getAccountDetails(""))
        })
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
    
    private func expect<S>(_ sut: TrackerSpy<S>, toReceive events: [S?], when action: () -> Void, file: StaticString = #file, line: UInt = #line) where S: Equatable {
        let spy = TrackerSpy<S>()
        Resolver.register { spy as Tracker }
        
        action()
        
        XCTAssertEqual(spy.publishedEvents, events, file: file, line: line)
    }
    
}
extension ScreenViewEvent: Equatable {
    public static func == (lhs: ScreenViewEvent, rhs: ScreenViewEvent) -> Bool {
        (lhs.name == rhs.name) && (lhs.journey == rhs.journey)
    }
}

private final class DummyAccountsListUseCase: AccountsListUseCase {
    func getAccountSummary(_ completion: @escaping (Result<AccountsJourney.AccountsSummary, AccountsJourney.ErrorResponse>) -> Void) {
        
    }
}

private final class DummyAccountDetailsUseCase: AccountDetailsUseCase {
    func getAccountDetail(arrangementId: String, _ completion: @escaping (Result<AccountsJourney.AccountDetailsModel, AccountsJourney.ErrorResponse>) -> Void) {
        
    }
}
