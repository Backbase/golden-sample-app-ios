//
//  AccountSummary.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 11/10/2023.
//

import Foundation

extension AccountsJourney {
    public struct AccountsSummary: Codable, Equatable {
        public let customProducts: [CustomProducts]?
        public let aggregatedBalance: AggregatedBalance?
        public let currentAccounts: CurrentAccounts?
        public let savingsAccounts: SavingsAccounts?
        public let termDeposits: TermDeposits?
        public let loans: Loans?
        public let creditCards: CreditCards?
        public let debitCards: DebitCards?
        public let investmentAccounts: InvestmentAccounts?
        public let additions: [String: String]?
        
        public init(
            customProducts: [CustomProducts],
            aggregatedBalance: AggregatedBalance?,
            currentAccounts: CurrentAccounts?,
            savingsAccounts: SavingsAccounts?,
            termDeposits: TermDeposits?,
            loans: Loans?,
            creditCards: CreditCards?,
            debitCards: DebitCards?,
            investmentAccounts: InvestmentAccounts?,
            additions: [String : String]?
        ) {
            self.customProducts = customProducts
            self.aggregatedBalance = aggregatedBalance
            self.currentAccounts = currentAccounts
            self.savingsAccounts = savingsAccounts
            self.termDeposits = termDeposits
            self.loans = loans
            self.creditCards = creditCards
            self.debitCards = debitCards
            self.investmentAccounts = investmentAccounts
            self.additions = additions
        }
    }

}

