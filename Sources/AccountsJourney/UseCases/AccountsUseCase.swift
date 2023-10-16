//
//  AccountsUseCase.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 11/10/2023.
//

import Foundation

public protocol AccountsUseCase {
    func getAccountSummary(_ completion: @escaping(Result<AccountsSummary, ErrorResponse>) -> Void)
}
