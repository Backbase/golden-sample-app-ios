import XCTest
import Resolver
import BackbaseObservability
@testable import AccountsJourney

final class AccountsJourneyObservabilityTests: XCTestCase {
    
    private var userActionSpy: TrackerSpy<UserActionEvent>?
    private var screenViewEventsSpy: TrackerSpy<ScreenViewEvent>?
    
    override func setUp() {
        super.setUp()
        var accountsJourneyConfig = AccountsJourney.Configuration()
        Resolver.register { accountsJourneyConfig }
    }
    
    override func tearDown() {
        super.tearDown()
        userActionSpy = nil
        screenViewEventsSpy = nil
    }
    
    func test_noEventIsPublishedUponInitializationOfViewModel() {
        userActionSpy = TrackerSpy<UserActionEvent>()
        expect(userActionSpy!, toReceive: [], when: {
            _ = AccountsListViewModel()
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
