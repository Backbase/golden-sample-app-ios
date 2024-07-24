//
//  CustomAccountListSummaryUseCase.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 24/07/2024.
//

import Foundation
import AccountsJourney

final class CustomAccountListSummaryUseCase: AccountsListUseCase {
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

extension CustomAccountListSummaryUseCase {
    private func generatedCurrentAccounts(amount: Int = Int.random(in: 2...10)) -> AccountsJourney.CurrentAccounts {
        
        var accounts = [AccountsJourney.CurrentAccount]()
        for _ in 0...amount {
            let status = Bool.random() ? "Active": "Closed"
            let account = AccountsJourney.CurrentAccount(
                availableBalance: String(Int.random(in: 0..<10000)),
                bban: "*******************" + String(Int.random(in: 1..<100)),
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

extension CustomAccountListSummaryUseCase {
    private func generateSavingsAccounts(amount: Int = Int.random(in: 2...10)) -> AccountsJourney.SavingsAccounts {
        
        var savingsAccounts = [AccountsJourney.SavingsAccount]()
        for _ in 0...amount {
            let status = Bool.random() ? "Active": "Closed"
            let account = AccountsJourney.SavingsAccount(
                availableBalance: String(Int.random(in: 0..<10000)),
                bban: "*******************" + String(Int.random(in: 1..<100)),
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

extension CustomAccountListSummaryUseCase {
    private func randomString(for sample: String) -> String {
        return sample
    }
}
