//
//  AccountsJourneyViewModel.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 12/10/2023.
//

import Foundation
import Resolver
import Combine
import BackbaseDesignSystem

final class AccountsListViewModel: NSObject {
    
    // MARK: - Properties
    @Published private(set) var allAccounts = [AccountUIModel]()
    @Published private(set) var screenState: AccountListScreenState = .loading
    
    // MARK: - Private

    private let accountsUseCase = CustomAccountsUseCase()

    // MARK: - Methods
    func onEvent(_ event: AccountListScreenEvent) {
        switch event {
        case .getAccounts:
            getAccountSummary(fromEvent: .getAccounts)
        case .refresh:
            getAccountSummary(fromEvent: .refresh)
        case .search(let searchString):
            getAccountSummary(fromEvent: .search(searchString))
        }
    }

    func getAccountSummary(fromEvent event: AccountListScreenEvent) {
        screenState  = .loading

        Task {
            do {
                let accountsSummaryResponse = try await self.accountsUseCase.getAccounts()
                
                var query = ""

                if case let .search(searchString) = event {
                    query = searchString
                }
                
                allAccounts = accountsSummaryResponse.toMapUI().generateList(query: query)

                if allAccounts.isEmpty {
                    screenState = .emptyResults(stateViewConfiguration(for: .noAccounts))
                } else {
                    screenState = .loaded
                }
            } catch {
                screenState = .hasError(stateViewConfiguration(for: .loadingFailure(nil)))
            }
        }
    }
}
