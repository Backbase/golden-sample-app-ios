//
//  AccountsUseCase.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 11/10/2023.
//

import Foundation

protocol AccountsUseCase {
    func getAccountSummary(_ completion: @escaping(Result<AccountSummary, ErrorResponse>) -> Void)
}
