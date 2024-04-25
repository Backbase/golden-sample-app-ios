//
//  MockAccountDetailsUseCase.swift
//  SnapshotTests
//
//  Created by Backbase R&D B.V. on 14/03/2024.
//

import Foundation
import AccountsJourney
import ArrangementsClient2Gen2


class MockAccountDetailsUseCase: AccountDetailsUseCase {
    private var shouldReturnError: Bool
    private var fileName: String
    
    init(shouldReturnError: Bool = false, fileName: String = "arrangement.json") {
        self.shouldReturnError = shouldReturnError
        self.fileName = fileName
    }
    
    func getAccountDetail(
        arrangementId: String,
        _ completion: @escaping (Result<AccountsJourney.AccountDetailsModel, AccountsJourney.ErrorResponse>) -> Void) {
            if shouldReturnError {
                completion(.failure(AccountsJourney.ErrorResponse(statusCode: 404, data: nil, error: AccountDetails.Error.invalidResponse)))
            } else {
                let data = Bundle.data(from: fileName)
                
                guard let arrangementDetails = try? JSONDecoder().decode(ArrangementsClient2Gen2.AccountArrangementItem.self, from: data) else {
                    completion(.failure(.init()))
                    return
                }
                
                completion(.success(arrangementDetails.toDomainModel()))
            }
        }
    
}
