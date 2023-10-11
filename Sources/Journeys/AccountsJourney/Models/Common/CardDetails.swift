//
//  CardDetails.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 11/10/2023.
//

import Foundation


/// DTO that represents details for a credit card.
 struct CardDetails: Equatable {
    /// Optional additions. Defaults to `nil`.
     let additions: [String: String]?
    /// This field specifies the Card Provider associated with the Account.
    /// - *Example*: Maestro, Visa, Master Card, American Express or Discover.
     let cardProvider: String
    /// A card can either be Secured or Unsecured.
    /// - *true*: amount deposited in the CC determines the Limit.
    /// - *false*: credit limit is based off various factors including the CC holder’s Credit Score,
    /// Credit History and is determined by the lending bank.
     let secured: Bool?
    /// The amount of money currently available for a bank cash advance.
    /// This is calculated given the portion of the CashCreditLimit which has been used for Cash Advance Transactions.
     let availableCashCredit: Double?
    /// The portion of the credit limit available for bank cash advance transactions.
     let cashCreditLimit: Double?
    /// The Date the last payment was made on the Credit-based arrangement.
     let lastPaymentDate: Date?
    /// The amount of the last payment that was made on the Credit-based arrangement.
     let lastPaymentAmount: Double?
    /// The charge triggered by infractions such as late credit card payments. It can be expressed as fixed amount or as percent.
    /// - *Example*:   - *12.32*: as fixed amount   - *3.14%*: as percent
     let latePaymentFee: String?
    /// The date of the previous billing cycle for the arrangement.
     let previousStatementDate: Date?
    /// The amount owed on the credit card as of the previous billing cycle.
     let previousStatementBalance: Double?
    /// The amount owed on the credit card as of the latest billing cycle.
     let statementBalance: Double?
    
    /// Create a new `CardDetails` object.
    /// - Parameters:
    ///   - additions: Optional additions. Defaults to `nil`
    ///   - cardProvider: This field specifies the Card Provider associated with the Account.
    ///   - secured: The amount of money currently available for a bank cash advance. Defaults to `nil`
    ///   - availableCashCredit: The amount of money currently available for a bank cash advance. Defaults to `nil`
    ///   - cashCreditLimit: The portion of the credit limit available for bank cash advance transactions. Defaults to `nil`
    ///   - lastPaymentDate: The Date the last payment was made on the Credit-based arrangement. Defaults to `nil`
    ///   - lastPaymentAmount: The amount of the last payment that was made on the Credit-based arrangement. Defaults to `nil`
    ///   - latePaymentFee: The charge triggered by infractions such as late credit card payments. Defaults to `nil`
    ///   - previousStatementDate: The date of the previous billing cycle for the arrangement. Defaults to `nil`
    ///   - previousStatementBalance: The amount owed on the credit card as of the previous billing cycle. Defaults to `nil`
    ///   - statementBalance: The amount owed on the credit card as of the latest billing cycle. Defaults to `nil`
     init(additions: [String: String]? = nil,
                cardProvider: String,
                secured: Bool? = nil,
                availableCashCredit: Double? = nil,
                cashCreditLimit: Double? = nil,
                lastPaymentDate: Date? = nil,
                lastPaymentAmount: Double? = nil,
                latePaymentFee: String? = nil,
                previousStatementDate: Date? = nil,
                previousStatementBalance: Double? = nil,
                statementBalance: Double? = nil) {
        self.additions = additions
        self.cardProvider = cardProvider
        self.secured = secured
        self.availableCashCredit = availableCashCredit
        self.cashCreditLimit = cashCreditLimit
        self.lastPaymentDate = lastPaymentDate
        self.lastPaymentAmount = lastPaymentAmount
        self.latePaymentFee = latePaymentFee
        self.previousStatementDate = previousStatementDate
        self.previousStatementBalance = previousStatementBalance
        self.statementBalance = statementBalance
    }
}
