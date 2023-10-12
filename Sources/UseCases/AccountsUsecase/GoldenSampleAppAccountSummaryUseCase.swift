//
//  GoldenSampleAppAccountSummaryUseCase.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 12/10/2023.
//

import Foundation
import ArrangementsClient2Gen2
import ClientCommonGen2

final class GoldenSampleAppAccountSummaryUseCase: AccountsUseCase {
    
    private let client: ArrangementsClient2Gen2.ProductSummaryAPIProtocol
    
    // MARK: - Init
    init(client: ProductSummaryAPIProtocol) {
        self.client = client
    }
    
    func getAccountSummary(_ completion: @escaping (Result<AccountSummary, ErrorResponse>) -> Void) {
        
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
                                error: AccountsJourney.Error.invalidResponse
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
                                error: AccountsJourney.Error.emptyResponse
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

