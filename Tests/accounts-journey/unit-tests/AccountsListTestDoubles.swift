import ArrangementsClient2Gen2
import BackbaseObservability
import ClientCommonGen2
import Foundation
@testable import AccountsJourney

// Test doubles and fixtures shared by the accounts list tests.

extension ProductSummary {

    static func decode(_ json: String) throws -> ProductSummary {
        try JSONDecoder().decode(ProductSummary.self, from: Data(json.utf8))
    }

    /// One current account, one savings account, one closed loan and one custom product.
    static func fixture() throws -> ProductSummary {
        try decode("""
        {
          "currentAccounts": {"products": [
            {"id": "current-1", "name": "Main account", "bookedBalance": "1250.50", "currency": "EUR",
             "BBAN": "BBAN-1", "visible": true, "state": {"state": "Active"}, "debitCardsItems": []}
          ]},
          "savingsAccounts": {"products": [
            {"id": "savings-1", "name": "Holiday savings", "bookedBalance": "9800", "currency": "EUR",
             "IBAN": "IBAN-2", "visible": true, "state": {"state": "Active"}, "debitCardsItems": []}
          ]},
          "loans": {"products": [
            {"id": "loan-1", "name": "Car loan", "bookedBalance": "-12000", "currency": "EUR",
             "BBAN": "BBAN-3", "visible": false, "state": {"state": "Closed"}, "debitCardsItems": []}
          ]},
          "customProductKinds": [{"name": "Other", "products": [
            {"id": "custom-1", "name": "Gold bars", "bookedBalance": "5", "currency": "USD",
             "productKindName": "Precious", "visible": true, "state": {"state": "Active"}, "debitCardsItems": []}
          ]}]
        }
        """)
    }
}

final class StubAccountsListUseCase: AccountsListUseCase {

    var result: Result<ProductSummary, ErrorResponse>
    private(set) var callCount = 0

    init(result: Result<ProductSummary, ErrorResponse>) {
        self.result = result
    }

    func getAccountSummary(_ completion: @escaping (Result<ProductSummary, ErrorResponse>) -> Void) {
        callCount += 1
        completion(result)
    }
}

final class DelayedFailingUseCase: AccountsListUseCase {

    private(set) var callCount = 0

    func getAccountSummary(_ completion: @escaping (Result<ProductSummary, ErrorResponse>) -> Void) {
        callCount += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            completion(.failure(.error(500, nil, AccountsList.Error.invalidResponse)))
        }
    }
}

final class TrackerSpy: NSObject, Tracker {

    private(set) var screenViewNames = [String]()
    private(set) var userActionNames = [String]()

    func publish<T>(event: T) {
        if let event = event as? ScreenViewEvent {
            screenViewNames.append(event.name)
        }
        if let event = event as? UserActionEvent {
            userActionNames.append(event.name)
        }
    }

    func subscribe<T>(subscriber: AnyHashable, eventClass: T.Type, completion: @escaping (T) -> Void) {}
    func unsubscribe(subscriber: AnyHashable) {}
}
