//
//  CustomAccountListSummaryUseCase.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 24/07/2024.
//

import Foundation
import AccountsJourney

final class CustomAccountListSummaryUseCaseImpl: AccountsListUseCase {
    func getAccountSummary(_ completion: @escaping (Result<AccountsJourney.AccountsSummary, AccountsJourney.ErrorResponse>) -> Void) {
        let accountSummary = AccountsJourney.AccountsSummary(
            customProducts: [],
            aggregatedBalance: nil,
            currentAccounts: generatedCurrentAccounts(),
            savingsAccounts: generateSavingsAccounts(),
            termDeposits: nil,
            loans: nil,
            creditCards: nil,
            debitCards: nil,
            investmentAccounts: nil,
            additions: nil
        )
        
        completion(.success(accountSummary))
    }
}

extension CustomAccountListSummaryUseCaseImpl {
    private func generatedCurrentAccounts(amount: Int = Int.random(in: 2...10)) -> AccountsJourney.CurrentAccounts {
        
        var accounts = [AccountsJourney.CurrentAccount]()
        for _ in 0...amount {
            let status = Bool.random() ? "Active": "Closed"
            let balance = String(Int.random(in: 0..<10000))
            let account = AccountsJourney.CurrentAccount(
                bookedBalance: balance,
                availableBalance: balance,
                bban: "*******************" + String(Int.random(in: 1..<100)), currency: "KES,",
                debitCardsItems: [],
                name: randomString(for: "Current Account"),
                userPreferences: AccountsJourney.UserPreferences(
                    alias: randomString(for: "Current"),
                    visible: Bool.random(),
                    favorite: Bool.random()
                ),
                state: AccountsJourney.ProductState(
                    externalStateId: status,
                    state: status
                )
            )
            accounts.append(account)
        }
         
        return AccountsJourney.CurrentAccounts(
            products: accounts,
            name: "Fake Current Accounts",
            aggregatedBalance: nil,
            additions: nil
        )
    }
}

extension CustomAccountListSummaryUseCaseImpl {
    private func generateSavingsAccounts(amount: Int = Int.random(in: 2...10)) -> AccountsJourney.SavingsAccounts {
        
        var savingsAccounts = [AccountsJourney.SavingsAccount]()
        for _ in 0...amount {
            let status = Bool.random() ? "Active": "Closed"
            let balance = String(Int.random(in: 0..<10000))
            let account = AccountsJourney.SavingsAccount(
                bookedBalance: balance,
                availableBalance: balance,
                bban: "*******************" + String(Int.random(in: 1..<100)), currency: "KES",
                userPreferences: AccountsJourney.UserPreferences(
                    alias: randomString(for: "Savings"),
                    visible: Bool.random(),
                    favorite: Bool.random()
                ),
                state: AccountsJourney.ProductState(
                    externalStateId: status,
                    state: status
                )
            )
            savingsAccounts.append(account)
        }
            
        return AccountsJourney.SavingsAccounts(
            products: savingsAccounts,
            name: "Fake Savings Accounts",
            aggregatedBalance: nil,
            additions: nil
        )
    }
}

extension CustomAccountListSummaryUseCaseImpl {
    private func randomString(for sample: String) -> String {
        return sample
    }
}
