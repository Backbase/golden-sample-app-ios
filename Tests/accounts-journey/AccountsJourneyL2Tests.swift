//
//  AccountsJourneyL2Tests.swift
//  ios-golden-sample-app
//
//  Created by George Nyakundi on 27/05/2025.
//
import AccountsJourney
import Resolver
import XCTest

final class AccountsJourneyL2Tests: XCTestCase {
    func test_dummy() {
        Resolver.register { FakeAccountUseCase() as AccountsListUseCase }
        Resolver.register { AccountsJourney.Configuration() }
        
        Launcher()
            .launchApp()
        
    }
    
}

final class AccountsListScreenRobot {
    lazy private var accountName = "Sara Williams Williams"
}

final class Launcher {
    private var app = XCUIApplication()
    
    @discardableResult
    func launchApp() -> AccountsListScreenRobot {
        app.launchArguments += ["UITests"]
        app.launchArguments += ["UsingMocks"]
        return AccountsListScreenRobot()
    }
}

class Robot {
    private var app = XCUIApplication()
    func terminateApp() {
        XCUIApplication().terminate()
    }
    
    @discardableResult
    func pullToRefreshElement(element: XCUIElement) -> Self {
        XCTAssertTrue(element.waitForExistence(timeout: 2))
        let start = element.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let finish = element.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 100))
        start.press(forDuration: 0, thenDragTo: finish)
        XCTAssertTrue(element.waitForExistence(timeout: 20))
        if !element.visible(app) {
            XCTFail("Could not pull to refresh")
        }
        return self
    }
}

extension XCUIElement {
    func visible(_ app: XCUIApplication) -> Bool {
        guard self.exists && !self.frame.isEmpty else { return false }
        return app.windows.element(boundBy: 0).frame.contains(self.frame)
    }
}


final class FakeAccountUseCase: AccountsListUseCase {
    func getAccountSummary(_ completion: @escaping (Result<AccountsJourney.AccountsSummary, AccountsJourney.ErrorResponse>) -> Void) {
        completion(.success(.init(customProducts: [], aggregatedBalance: .none, currentAccounts: .init(products: [
            .init(bookedBalance: "0.4200000000", availableBalance: "0.4200000000", creditLimit: "0.00000", iban: .none, bban: "***************6944", currency: "USD", urgentTransferAllowed: .none, bic: "USXBUSHQXXX", bankBranchCode: "123123123", bankBranchCode2: .none, accountInterestRate: 3.00, valueDateBalance: .none, creditLimitUsage: 0.00000, creditLimitInterestRate: 2.00, creditLimitExpiryDate: .none, accruedInterest: .none, debitCardsItems: [], accountHolderNames: "Sara Williams Williams", startDate: .none, minimumRequiredBalance: .none, accountHolderAddressLine1: .none, accountHolderAddressLine2: .none, accountHolderStreetName: .none, town: .none, postCode: .none, countrySubDivision: .none, creditAccount: .none, debitAccount: .none, accountHolderCountry: .none, additions: .none, identifier: .none, unmaskableAttributes: [.bban], name: "Retirement Account", displayName: "Ivet Ivanova", externalTransferAllowed: true, crossCurrencyAllowed: true, productKindName: "Current Account", productTypeName: "Current Account", bankAlias: "Retirement Account", sourceId: .none, visible: true, accountOpeningDate: .now, lastUpdateDate: .now, userPreferences: .init(alias: "Ivet Ivanova", visible: false, favorite: true, additions: nil), state: .init(externalStateId: "Active", state: "Active", additions: .none), parentId: .none, subArrangements: .none, financialInstitutionId: .none, lastSyncDate: .none, nextClosingDate: .none, reservedAmount: .none, remainingPeriodicTransfers: .none, overdueSince: .none, externalAccountStatus: .none, cardDetails: .none, interestDetails: .none)
        ], name: "Current Accounts", aggregatedBalance: .none, additions: .none), savingsAccounts: .none, termDeposits: .none, loans: .none, creditCards: .none, debitCards: .none, investmentAccounts: .none, additions: .none)))
    }
}
