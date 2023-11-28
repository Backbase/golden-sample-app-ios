//
//  AccountDetailsUseCaseImp.swift
//  AccountsUseCase
//
//  Created by Backbase R&D B.V. on 28/11/2023.
//

import Foundation
import AccountsJourney
import ArrangementsClient2Gen2

public final class AccountDetailUseCaseImp: AccountDetailUseCase {
    private let client: ArrangementsClient2Gen2.ArrangementsAPIProtocol
    
    // MARK: - Init
    public init(client: ArrangementsAPIProtocol) {
        self.client = client
    }
    
    public func getAccountDetail(
        arrangementId: String,
        _ completion: @escaping (Result<AccountsJourney.AccountDetails, AccountsJourney.ErrorResponse>) -> Void) {
        
        let call = try? self.client.getArrangementByIdCall(
            params: ArrangementsAPI.GetArrangementByIdRequestParams.Builder(arrangementId: arrangementId).build()
        )
        
        call?.execute({ result in
            switch result {
            case let .success(response):
                guard let arrangementItem = response.body else {
                    return completion(
                        .failure(
                            AccountsJourney.ErrorResponse(
                                statusCode: response.statusCode,
                                data: nil,
                                error: AccountDetails.Error.invalidResponse
                            )
                        )
                    )
                }
                completion(.success(arrangementItem.toDomainModel()))
            case let .failure(error):
                return completion(.failure(
                    AccountsJourney.ErrorResponse(
                        error: error
                    )
                ))
            }
        })
    }
}
