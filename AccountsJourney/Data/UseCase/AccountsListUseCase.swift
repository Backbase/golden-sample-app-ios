//
//  AccountsListUseCase.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 11/10/2023.
//

import Foundation
import ArrangementsClient2Gen2
import ClientCommonGen2

public protocol AccountsListUseCase {
    func getAccountSummary(_ completion: @escaping (Result<ProductSummary, ClientCommonGen2.ErrorResponse>) -> Void)
}

public final class AccountsListSummaryUseCaseImp: AccountsListUseCase {

    private let client: ArrangementsClient2Gen2.ProductSummaryAPIProtocol

    // MARK: - Init
    public init(client: ProductSummaryAPIProtocol) {
        self.client = client
    }

    public func getAccountSummary(_ completion: @escaping (Result<ProductSummary, ClientCommonGen2.ErrorResponse>) -> Void) {

        let call = try? self.client.getProductSummaryCall(
            params: ProductSummaryAPI.GetProductSummaryRequestParams.Builder().build())

        call?.execute({ result in
            switch result {
            case let .success(response):
                guard let productSummary = response.body else {
                    return completion(
                        .failure(
                            .error(response.statusCode,
                                   nil,
                                   AccountsList.Error.invalidResponse)
                        )
                    )
                }

                completion(.success(productSummary))
            case let .failure(error):
                completion(.failure(error))
            }
        })
    }
}
