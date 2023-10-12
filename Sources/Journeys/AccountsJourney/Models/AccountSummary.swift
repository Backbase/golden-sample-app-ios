//
//  AccountSummary.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 11/10/2023.
//

import Foundation

struct AccountSummary: Equatable {
    let customProducts: [CustomProducts]
    let aggregatedBalance: AggregatedBalance?
    let currentAccounts: CurrentAccounts?
    let savingsAccounts: SavingsAccounts?
    let termDeposits: TermDeposits?
    let loans: Loans?
    let creditCards: CreditCards?
    let debitCards: DebitCards?
    let investmentAccounts: InvestmentAccounts?
    let additions: [String: String]?
    
    
    init(
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
