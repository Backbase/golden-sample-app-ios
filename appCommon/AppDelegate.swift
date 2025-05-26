//
//  AppDelegate.swift
//  AppCommon
//
//  Created by Backbase on 03/02/2025.
//

import UIKit
import Resolver
import Backbase
import AccountsJourney
import IdentityAuthenticationJourney

/**
 * The application delegate for the app.
 *
 * This class is responsible for handling application lifecycle events, such as
 * launching, terminating, and background transitions. It sets up the main
 * window, initializes the app's router, registers it with the dependency
 * resolver, configures authentication, and starts the app's initial flow.
 * It's generic over the `AppRouter` type, allowing for customization of the
 * navigation logic.
 *
 * - Generic Parameters:
 *   - Router: The type of `AppRouter` to use for navigation.  Must conform to `AppRouter` protocol.
 */
open class AppDelegate<Router: AppRouter>: UIResponder, UIApplicationDelegate {
    
    /// The main window of the application.
    public var window: UIWindow?
    
    /// Initializes the application delegate.
    ///
    /// This initializer calls the superclass initializer and performs any
    /// necessary setup, such as initializing the Backbase SDK.
    override public init() {
        super.init()
        setupBackbaseSDK()
    }
    
    ///
    /// Called when the application has finished launching.
    ///
    /// This method is responsible for setting up the application's initial
    /// state. It creates the main window, registers the app's router with the
    /// dependency resolver, configures authentication to handle session changes
    /// via the router, and starts the app by calling `didStartApp` on the router.
    ///
    /// - Parameters:
    ///   - application: The UIApplication instance.
    ///   - launchOptions: A dictionary of launch options.
    ///
    /// - Returns: `true` if the application launch was successful, `false` otherwise.
    ///
    open func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        
        let window = createWindow()
        self.window = window
        
        if !shouldUseMocks() {
            prepareForUITesting()
            let router = MockedAppRouter()
            Resolver.register { router }.implements(AppRouter.self)
            // Register Mocks
            Resolver.register { FakeAccountUseCase() as AccountsListUseCase }
            Resolver.register { AccountsJourney.Configuration() }
            router.didStartApp(window: window)
        } else {
            let router = Router()
            Resolver.register { router }.implements(AppRouter.self)
            
            Authentication.Configuration.appDefault.register(sessionChangeHandler: router.handleSessionChange)
            router.didStartApp(window: window)
        }
        return true
    }
    
    private func createWindow() -> UIWindow {
        let newWindow = UIWindow()
        newWindow.makeKeyAndVisible()
        return newWindow
    }
}

extension AppDelegate {
    func prepareForUITesting() {
        if ProcessInfo.processInfo.arguments.contains("UITests") {
            UIView.setAnimationsEnabled(false)
            window?.layer.speed = 100
        }
    }
    
    func shouldUseMocks() -> Bool {
        return ProcessInfo.processInfo.environment["UseMocks"] == "TRUE"
    }
}

final class FakeAccountUseCase: AccountsListUseCase {
    func getAccountSummary(_ completion: @escaping (Result<AccountsJourney.AccountsSummary, AccountsJourney.ErrorResponse>) -> Void) {
        completion(.success(.init(customProducts: [], aggregatedBalance: .none, currentAccounts: .init(products: [
            .init(bookedBalance: "0.4200000000", availableBalance: "0.4200000000", creditLimit: "0.00000", iban: .none, bban: "***************6944", currency: "USD", urgentTransferAllowed: .none, bic: "USXBUSHQXXX", bankBranchCode: "123123123", bankBranchCode2: .none, accountInterestRate: 3.00, valueDateBalance: .none, creditLimitUsage: 0.00000, creditLimitInterestRate: 2.00, creditLimitExpiryDate: .none, accruedInterest: .none, debitCardsItems: [], accountHolderNames: "Sara Williams Williams", startDate: .none, minimumRequiredBalance: .none, accountHolderAddressLine1: .none, accountHolderAddressLine2: .none, accountHolderStreetName: .none, town: .none, postCode: .none, countrySubDivision: .none, creditAccount: .none, debitAccount: .none, accountHolderCountry: .none, additions: .none, identifier: .none, unmaskableAttributes: [.bban], name: "Retirement Account", displayName: "Ivet Ivanova", externalTransferAllowed: true, crossCurrencyAllowed: true, productKindName: "Current Account", productTypeName: "Current Account", bankAlias: "Retirement Account", sourceId: .none, visible: true, accountOpeningDate: .now, lastUpdateDate: .now, userPreferences: .init(alias: "Ivet Ivanova", visible: false, favorite: true, additions: nil), state: .init(externalStateId: "Active", state: "Active", additions: .none), parentId: .none, subArrangements: .none, financialInstitutionId: .none, lastSyncDate: .none, nextClosingDate: .none, reservedAmount: .none, remainingPeriodicTransfers: .none, overdueSince: .none, externalAccountStatus: .none, cardDetails: .none, interestDetails: .none)
        ], name: "Current Accounts", aggregatedBalance: .none, additions: .none), savingsAccounts: .none, termDeposits: .none, loans: .none, creditCards: .none, debitCards: .none, investmentAccounts: .none, additions: .none)))
    }
}
