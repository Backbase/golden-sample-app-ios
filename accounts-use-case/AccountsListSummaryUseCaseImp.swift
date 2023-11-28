//
//  AccountsListSummaryUseCaseImp.swift
//  GoldenAccountsUseCase
//
//  Created by Backbase R&D B.V. on 12/10/2023.
//

import Foundation
import AccountsJourney
import ArrangementsClient2Gen2
import ClientCommonGen2

public final class AccountsListSummaryUseCaseImp: AccountsListUseCase {
    
    private let client: ArrangementsClient2Gen2.ProductSummaryAPIProtocol
    
    // MARK: - Init
    public init(client: ProductSummaryAPIProtocol) {
        self.client = client
    }
    
    public func getAccountSummary(_ completion: @escaping (Result<AccountsJourney.AccountsSummary, AccountsList.ErrorResponse>) -> Void) {
        
        let call = try? self.client.getProductSummaryCall(
            params: ProductSummaryAPI.GetProductSummaryRequestParams.Builder().build())
        
        call?.execute({ result in
            switch result {
            case let .success(response):
                guard let productSummary = response.body else {
                    return completion(
                        .failure(
                            AccountsList.ErrorResponse(
                                statusCode: response.statusCode,
                                data: nil,
                                error: AccountsList.Error.invalidResponse
                            )
                        )
                    )
                }
                
                completion(.success(productSummary.toDomainModel()))
            case let .failure(error):
                completion(.failure(AccountsList.ErrorResponse(error: error)))
            }
        })
    }
}
