//
//  AccountDetailUseCase.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 27/11/2023.
//

import Foundation

public protocol AccountDetailUseCase {
    func getAccountDetail(arrangementId: String, _ completion: @escaping(Result<AccountsJourney.AccountDetails, AccountsJourney.ErrorResponse>) -> Void)
}
