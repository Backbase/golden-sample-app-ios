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
    
    func test_noUserActionEventIsPublished_whenAccountsListViewModel_is_initialized() {
        let userActionSpy = TrackerSpy<UserActionEvent>()
        expect(userActionSpy, toReceive: [], when: {
            _ = AccountsListViewModel()
        })
    }
    
    func test_noScreenViewEventIsPublished_whenAccountListViewModel_is_initialized() {
        let screenViewEventsSpy = TrackerSpy<ScreenViewEvent>()
        expect(screenViewEventsSpy, toReceive: [], when: {
            _ = AccountsListViewModel()
        })
    }
    
    func test_accountsScreenEventIsPublished_whenTheAccountsViewLoads() {
        let screenViewEventsSpy = TrackerSpy<ScreenViewEvent>()
        
        expect(screenViewEventsSpy, toReceive: [ScreenViewEvent(.accounts_list)], when: {
            AccountsListViewModel().onEvent(.getAccounts)
            let viewDidAppearSubject = PassthroughSubject<Void, Never>()
            let userActionEventSubject = PassthroughSubject<UserActionEvent, Never>()
            let viewModel = AccountsListViewModel()
            viewModel.bind(viewDidAppearPublisher: viewDidAppearSubject.eraseToAnyPublisher(), userActionEventPublisher: userActionEventSubject.eraseToAnyPublisher())
            viewDidAppearSubject.send()
        })
    }
    
    func test_refresh_accountsUserActionEvent_isPublished_whenTheRefreshEventIsEmitted() {
        let userActionSpy = TrackerSpy<UserActionEvent>()
        
        expect(userActionSpy, toReceive: [UserActionEvent(.refresh_accounts)], when: {
            
            let viewDidAppearSubject = PassthroughSubject<Void, Never>()
            let userActionEventSubject = PassthroughSubject<UserActionEvent, Never>()
            let viewModel = AccountsListViewModel()
            viewModel.bind(viewDidAppearPublisher: viewDidAppearSubject.eraseToAnyPublisher(), userActionEventPublisher: userActionEventSubject.eraseToAnyPublisher())
            userActionEventSubject.send(UserActionEvent(.refresh_accounts))
        })
    }
    

    // MARK: - AccountDetails Tests
    func test_noUserActionEventIsPublished_whenAccountDetailsViewModel_is_initialized() {
        let userActionSpy = TrackerSpy<UserActionEvent>()
        expect(userActionSpy, toReceive: [], when: {
            _ = AccountDetailsViewModel()
        })
    }
    
    func test_noScreenViewEventIsPublished_whenAccountDetailsViewModel_is_initialized() {
        let screenViewEventsSpy = TrackerSpy<ScreenViewEvent>()
        expect(screenViewEventsSpy, toReceive: [], when: {
            _ = AccountDetailsViewModel()
        })
    }
    
    func test_accountsDetailsScreenEventIsPublished_whenTheAccountsDetailsViewLoads() {
        let screenViewEventsSpy = TrackerSpy<ScreenViewEvent>()

        expect(screenViewEventsSpy, toReceive: [ScreenViewEvent(.account_details)], when: {
            let valueSubject = PassthroughSubject<Void, Never>()
            let viewModel = AccountDetailsViewModel()
            viewModel.bind(viewDidAppear: valueSubject.eraseToAnyPublisher())
            valueSubject.send()
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
        
        XCTAssertEqual(spy.publishedEvents, [], "No events should be published before the action() closure.", file: file, line: line)
        
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
