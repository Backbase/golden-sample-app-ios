//
//  CardDetailsMapper.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 12/10/2023.
//

import Foundation
import AccountsJourney
import ArrangementsApi

extension ArrangementsApi.CardDetails {
    public func toDomainModel() -> AccountsJourney.CardDetails {
        AccountsJourney.CardDetails(
            additions: self.additions,
            cardProvider: self.cardProvider,
            secured: self.secured,
            availableCashCredit: self.availableCashCredit,
            cashCreditLimit: self.cashCreditLimit,
            lastPaymentDate: self.lastPaymentDate,
            lastPaymentAmount: self.lastPaymentAmount,
            latePaymentFee: self.latePaymentFee,
            previousStatementDate: self.previousStatementDate,
            previousStatementBalance: self.previousStatementBalance,
            statementBalance: self.statementBalance
        )
    }
}
