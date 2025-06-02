//
//  AppDelegate+UITesting.swift
//  ios-golden-sample-app
//
//  Created by George Nyakundi on 02/06/2025.
//
import Foundation
import UIKit
import Resolver
import AccountsJourney
import IdentityAuthenticationJourney
import ClientCommonGen2


extension AppDelegate {
    func setupRouter(with window: UIWindow) {
        if shouldUseMocks() {
            prepareForUITesting()
            let router = MockedAppRouter()
            Resolver.register { router }.implements(AppRouter.self)
            if let error = ProcessInfo.processInfo.environment["hasError"] {
                let callError = CallError.errorFromString(error)
                let mockedAccountsUseCase = MockedAccountsUseCase(responseType: .failure(callError))
                Resolver.register { mockedAccountsUseCase as AccountsListUseCase }
            } else {
                Resolver.register { MockedAccountsUseCase(responseType: .success) as AccountsListUseCase }
            }

            Resolver.register { AccountsJourney.Configuration() }
            router.didStartApp(window: window)
        } else {
            let router = Router()
            Resolver.register { router }.implements(AppRouter.self)

            Authentication.Configuration.appDefault.register(sessionChangeHandler: router.handleSessionChange)
            router.didStartApp(window: window)
        }
    }
}

extension CallError {
    static func errorFromString(_ str: String) -> Self {
        if str == "nilHTTPResponse" {
            return CallError.nilHTTPResponse(nil)
        }

        return .emptyDataResponse
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
        return ProcessInfo.processInfo.arguments.contains("UseMocks")
    }
}

enum ResponseType {
    case failure(Error?)
    case success
}

// swiftlint:disable line_length
final class MockedAccountsUseCase: AccountsListUseCase {
    private var responseType: ResponseType


    init(responseType: ResponseType) {
        self.responseType = responseType
    }

    func getAccountSummary(_ completion: @escaping (Result<AccountsJourney.AccountsSummary, AccountsJourney.ErrorResponse>) -> Void) {
        switch responseType {
        case .failure(let error):
            completion(.failure(.init(error: error)))
        case .success:
            completion(.success(.init(customProducts: [], aggregatedBalance: .none, currentAccounts: .init(products: [
                .init(bookedBalance: "0.4200000000", availableBalance: "0.4200000000", creditLimit: "0.00000", iban: .none, bban: "***************6944", currency: "USD", urgentTransferAllowed: .none, bic: "USXBUSHQXXX", bankBranchCode: "123123123", bankBranchCode2: .none, accountInterestRate: 3.00, valueDateBalance: .none, creditLimitUsage: 0.00000, creditLimitInterestRate: 2.00, creditLimitExpiryDate: .none, accruedInterest: .none, debitCardsItems: [], accountHolderNames: "Sara Williams Williams", startDate: .none, minimumRequiredBalance: .none, accountHolderAddressLine1: .none, accountHolderAddressLine2: .none, accountHolderStreetName: .none, town: .none, postCode: .none, countrySubDivision: .none, creditAccount: .none, debitAccount: .none, accountHolderCountry: .none, additions: .none, identifier: .none, unmaskableAttributes: [.bban], name: "Retirement Account", displayName: "Ivet Ivanova", externalTransferAllowed: true, crossCurrencyAllowed: true, productKindName: "Current Account", productTypeName: "Current Account", bankAlias: "Retirement Account", sourceId: .none, visible: true, accountOpeningDate: .now, lastUpdateDate: .now, userPreferences: .init(alias: "Ivet Ivanova", visible: false, favorite: true, additions: nil), state: .init(externalStateId: "Active", state: "Active", additions: .none), parentId: .none, subArrangements: .none, financialInstitutionId: .none, lastSyncDate: .none, nextClosingDate: .none, reservedAmount: .none, remainingPeriodicTransfers: .none, overdueSince: .none, externalAccountStatus: .none, cardDetails: .none, interestDetails: .none),
                .init(bookedBalance: "0.4200000000", availableBalance: "0.4200000000", creditLimit: "0.00000", iban: .none, bban: "***************6945", currency: "USD", urgentTransferAllowed: .none, bic: "USXBUSHQXXX", bankBranchCode: "123123123", bankBranchCode2: .none, accountInterestRate: 3.00, valueDateBalance: .none, creditLimitUsage: 0.00000, creditLimitInterestRate: 2.00, creditLimitExpiryDate: .none, accruedInterest: .none, debitCardsItems: [], accountHolderNames: "Sarah William", startDate: .none, minimumRequiredBalance: .none, accountHolderAddressLine1: .none, accountHolderAddressLine2: .none, accountHolderStreetName: .none, town: .none, postCode: .none, countrySubDivision: .none, creditAccount: .none, debitAccount: .none, accountHolderCountry: .none, additions: .none, identifier: .none, unmaskableAttributes: [.bban], name: "Retirement Account 2", displayName: "Sarah William", externalTransferAllowed: true, crossCurrencyAllowed: true, productKindName: "Current Account", productTypeName: "Current Account", bankAlias: "unRetirement Account", sourceId: .none, visible: true, accountOpeningDate: .now, lastUpdateDate: .now, userPreferences: .init(alias: "Sarah William", visible: false, favorite: true, additions: nil), state: .init(externalStateId: "Active", state: "Active", additions: .none), parentId: .none, subArrangements: .none, financialInstitutionId: .none, lastSyncDate: .none, nextClosingDate: .none, reservedAmount: .none, remainingPeriodicTransfers: .none, overdueSince: .none, externalAccountStatus: .none, cardDetails: .none, interestDetails: .none),
                .init(bookedBalance: "0.4200000000", availableBalance: "0.4200000000", creditLimit: "0.00000", iban: .none, bban: "***************6946", currency: "USD", urgentTransferAllowed: .none, bic: "USXBUSHQXXX", bankBranchCode: "123123123", bankBranchCode2: .none, accountInterestRate: 3.00, valueDateBalance: .none, creditLimitUsage: 0.00000, creditLimitInterestRate: 2.00, creditLimitExpiryDate: .none, accruedInterest: .none, debitCardsItems: [], accountHolderNames: "Sarah Williams II", startDate: .none, minimumRequiredBalance: .none, accountHolderAddressLine1: .none, accountHolderAddressLine2: .none, accountHolderStreetName: .none, town: .none, postCode: .none, countrySubDivision: .none, creditAccount: .none, debitAccount: .none, accountHolderCountry: .none, additions: .none, identifier: .none, unmaskableAttributes: [.bban], name: "Retirement Account 3", displayName: "Sarah Williams II", externalTransferAllowed: true, crossCurrencyAllowed: true, productKindName: "Current Account", productTypeName: "Current Account", bankAlias: "Family Account", sourceId: .none, visible: true, accountOpeningDate: .now, lastUpdateDate: .now, userPreferences: .init(alias: "Sarah Williams II", visible: false, favorite: true, additions: nil), state: .init(externalStateId: "Active", state: "Active", additions: .none), parentId: .none, subArrangements: .none, financialInstitutionId: .none, lastSyncDate: .none, nextClosingDate: .none, reservedAmount: .none, remainingPeriodicTransfers: .none, overdueSince: .none, externalAccountStatus: .none, cardDetails: .none, interestDetails: .none),
                .init(bookedBalance: "0.4200000000", availableBalance: "0.4200000000", creditLimit: "0.00000", iban: .none, bban: "***************6947", currency: "USD", urgentTransferAllowed: .none, bic: "USXBUSHQXXX", bankBranchCode: "123123123", bankBranchCode2: .none, accountInterestRate: 3.00, valueDateBalance: .none, creditLimitUsage: 0.00000, creditLimitInterestRate: 2.00, creditLimitExpiryDate: .none, accruedInterest: .none, debitCardsItems: [], accountHolderNames: "Sarah Williams III", startDate: .none, minimumRequiredBalance: .none, accountHolderAddressLine1: .none, accountHolderAddressLine2: .none, accountHolderStreetName: .none, town: .none, postCode: .none, countrySubDivision: .none, creditAccount: .none, debitAccount: .none, accountHolderCountry: .none, additions: .none, identifier: .none, unmaskableAttributes: [.bban], name: "Family Account", displayName: "Sarah Williams III", externalTransferAllowed: true, crossCurrencyAllowed: true, productKindName: "Current Account", productTypeName: "Current Account", bankAlias: "Family Account", sourceId: .none, visible: true, accountOpeningDate: .now, lastUpdateDate: .now, userPreferences: .init(alias: "Sarah Williams III", visible: false, favorite: true, additions: nil), state: .init(externalStateId: "Active", state: "Active", additions: .none), parentId: .none, subArrangements: .none, financialInstitutionId: .none, lastSyncDate: .none, nextClosingDate: .none, reservedAmount: .none, remainingPeriodicTransfers: .none, overdueSince: .none, externalAccountStatus: .none, cardDetails: .none, interestDetails: .none)
            ], name: "Current Accounts", aggregatedBalance: .none, additions: .none), savingsAccounts: .none, termDeposits: .none, loans: .none, creditCards: .none, debitCards: .none, investmentAccounts: .none, additions: .none)))
        }
    }
}
// swiftlint:enable line_length
