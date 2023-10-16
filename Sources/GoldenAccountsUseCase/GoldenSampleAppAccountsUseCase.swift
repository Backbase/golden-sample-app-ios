//
//  GoldenSampleAppAccountsUseCase.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 12/10/2023.
//

import Foundation
import AccountsJourney
import ArrangementsClient2Gen2
import ClientCommonGen2

final class GoldenSampleAppAccountsUseCase: AccountsUseCase {
    
    private let client: ArrangementsClient2Gen2.ProductSummaryAPIProtocol
    
    // MARK: - Init
    init(client: ProductSummaryAPIProtocol) {
        self.client = client
    }
    
    func getAccountSummary(_ completion: @escaping (Result<AccountsJourney.AccountsSummary, AccountsJourney.ErrorResponse>) -> Void) {
        
        let call = try? self.client.getProductSummaryCall(
            params: ProductSummaryAPI.GetProductSummaryRequestParams.Builder().build())
        
        call?.execute({ result in
            switch result {
            case let .success(response):
                guard let productSummary = response.body else {
                    return completion(
                        .failure(
                            ErrorResponse(
                                statusCode: response.statusCode,
                                data: nil,
                                error: AccountsJourneyError.invalidResponse
                            )
                        )
                    )
                }
                
                guard let body = response.body else {
                    return completion(
                        .failure(
                            ErrorResponse(
                                statusCode: response.statusCode,
                                data: nil,
                                error: AccountsJourneyError.emptyResponse
                            )
                        )
                    )
                }
                completion(.success(body.toDomainModel()))
            case let .failure(error):
                completion(.failure(ErrorResponse(error: error)))
            }
        })
    }
}
