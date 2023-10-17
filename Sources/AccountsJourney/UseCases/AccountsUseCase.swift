//
//  AccountsUseCase.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 11/10/2023.
//

import Foundation

public protocol AccountsUseCase {
    func getAccountSummary(_ completion: @escaping(Result<AccountsSummary, ErrorResponse>) -> Void)
}