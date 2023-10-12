//
//  CardDetailsMapper.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 12/10/2023.
//

import Foundation
import ArrangementsClient2Gen2

extension ArrangementsClient2Gen2.CardDetails {
    func toDomainModel() -> CardDetails {
        CardDetails(
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
