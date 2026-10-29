//
//  AccountsListModel.swift
//  AccountsJourney
//

import ArrangementsClient2Gen2
import ClientCommonGen2
import Foundation

/// The model of the accounts list: it owns the data access and the navigation.
@MainActor
final class AccountsListModel: AccountsListModeling {

    private let useCase: AccountsListUseCase
    private let routing: AccountsListRouting

    /// - Parameters:
    ///   - useCase: Loads the accounts.
    ///   - routing: Navigates away from the accounts list.
    init(useCase: AccountsListUseCase, routing: AccountsListRouting) {
        self.useCase = useCase
        self.routing = routing
    }

    func fetchAccountSummary() async -> Result<ProductSummary, ErrorResponse> {
        let useCase = useCase
        return await withCheckedContinuation { continuation in
            useCase.getAccountSummary { continuation.resume(returning: $0) }
        }
    }

    func navigateToDetails(ofAccountWithID id: String) {
        routing.navigateToDetails(ofAccountWithID: id)
    }
}
