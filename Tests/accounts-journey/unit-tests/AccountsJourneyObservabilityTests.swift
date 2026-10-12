import XCTest
import Combine
import Resolver
import BackbaseObservability
import ClientCommonGen2
import ArrangementsClient2Gen2
@testable import AccountsJourney

final class AccountsJourneyObservabilityTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        let accountsJourneyConfig = AccountsJourney.Configuration()
        Resolver.register { accountsJourneyConfig }
        Resolver.register { DummyAccountDetailsUseCase() as AccountDetailsUseCase }
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

private final class DummyAccountDetailsUseCase: AccountDetailsUseCase {
    func getAccountDetail(arrangementId: String, _ completion: @escaping (Result<ArrangementsClient2Gen2.AccountArrangementItem, ClientCommonGen2.ErrorResponse>) -> Void) {}
}
