//
//  AccountDetailUseCase.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 27/11/2023.
//

import Foundation
import ArrangementsClient2Gen2
import ClientCommonGen2

public protocol AccountDetailsUseCase {
    func getAccountDetail(arrangementId: String, _ completion: @escaping (Result<AccountArrangementItem, ClientCommonGen2.ErrorResponse>) -> Void)
}

public final class AccountDetailUseCaseImp: AccountDetailsUseCase {
    private let client: ArrangementsClient2Gen2.ArrangementsAPIProtocol

    // MARK: - Init
    public init(client: ArrangementsAPIProtocol) {
        self.client = client
    }

    public func getAccountDetail(arrangementId: String, _ completion: @escaping (Result<AccountArrangementItem, ClientCommonGen2.ErrorResponse>) -> Void) {

        let call = try? self.client.getArrangementByIdCall(
            params: ArrangementsAPI.GetArrangementByIdRequestParams.Builder(arrangementId: arrangementId).build()
        )

        call?.execute({ result in
            switch result {
            case let .success(response):
                guard let arrangementItem = response.body else {
                    return completion(
                        .failure(
                            .error(response.statusCode,
                                   nil,
                                   AccountDetails.Error.invalidResponse)
                        )
                    )
                }
                completion(.success(arrangementItem))
            case let .failure(error):
                return completion(.failure(error))
            }
        })
    }
}
