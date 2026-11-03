//
//  AccountDetailsModel.swift
//  AccountsJourney
//

import ArrangementsClient2Gen2
import ClientCommonGen2
import Foundation

/// The model of the account details: it owns the identity of the account and the data access.
@MainActor
final class AccountDetailsModel: AccountDetailsModeling {

    private let arrangementId: String
    private let useCase: AccountDetailsUseCase

    /// - Parameters:
    ///   - arrangementId: The id of the account to show.
    ///   - useCase: Loads the account.
    init(arrangementId: String, useCase: AccountDetailsUseCase) {
        self.arrangementId = arrangementId
        self.useCase = useCase
    }

    func fetchAccountDetail() async -> Result<AccountArrangementItem, ErrorResponse> {
        let useCase = useCase
        let arrangementId = arrangementId
        return await withCheckedContinuation { continuation in
            useCase.getAccountDetail(arrangementId: arrangementId) { continuation.resume(returning: $0) }
        }
    }
}
