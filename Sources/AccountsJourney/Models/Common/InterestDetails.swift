//
//  InterestDetails.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 11/10/2023.
//

import Foundation

/// DTO that represents interest details for a credit card.
public struct InterestDetails: Equatable {
    /// Optional additions. Defaults to `nil`.
    public let additions: [String: String]?
    /// Last year's interest that was earned (credit interest) or due (debit interest).
    public let lastYearAccruedInterest: Double?
    /// Total amount of interest that is being withheld up to date and the bank provides 1099
    /// document end of the year for Tax return purpose.
    /// - *Example*:   - *12.32*: as fixed amount   - *3.14%*: as percent
    public let dividendWithheldYTD: String?
    /// The real rate of return earned on a savings deposit or investment taking into account the effect of compounding interest.
    public let annualPercentageYield: Double?
    /// The Interest charge that is added monthly on the outstanding cash advance due on a credit card.
    public let cashAdvanceInterestRate: Double?
    /// The Interest charge triggered by infractions such as late credit card payments.
    public let penaltyInterestRate: Double?
    
    /// Create a new `InterestDetails` object.
    /// - Parameters:
    ///   - additions: Optional additions. Defaults to `nil`
    ///   - lastYearAccruedInterest: Last year's interest that was earned (credit interest) or due (debit interest). Defaults to `nil`
    ///   - dividendWithheldYTD: Total amount of interest that is being withheld up to date and the bank provides 1099
    ///   document end of the year for Tax return purpose.
    ///    Defaults to `nil`
    ///   - annualPercentageYield: The real rate of return earned on a savings deposit or investment taking into account
    ///    the effect of compounding interest. Defaults to `nil`
    ///   - cashAdvanceInterestRate: The Interest charge that is added monthly on the outstanding cash advance due on a credit card.
    ///   Defaults to `nil`
    ///   - penaltyInterestRate: The Interest charge triggered by infractions such as late credit card payments. Defaults to `nil`
    public init(additions: [String: String]? = nil,
         lastYearAccruedInterest: Double? = nil,
         dividendWithheldYTD: String? = nil,
         annualPercentageYield: Double? = nil,
         cashAdvanceInterestRate: Double? = nil,
         penaltyInterestRate: Double? = nil) {
        self.additions = additions
        self.lastYearAccruedInterest = lastYearAccruedInterest
        self.dividendWithheldYTD = dividendWithheldYTD
        self.annualPercentageYield = annualPercentageYield
        self.cashAdvanceInterestRate = cashAdvanceInterestRate
        self.penaltyInterestRate = penaltyInterestRate
    }
}
