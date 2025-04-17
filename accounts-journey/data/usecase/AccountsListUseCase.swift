//
//  AccountsListUseCase.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 11/10/2023.
//

import Foundation

public protocol AccountsListUseCase {
    func getAccountSummary(_ completion: @escaping (Result<AccountsJourney.AccountsSummary, AccountsJourney.ErrorResponse>) -> Void)
}
