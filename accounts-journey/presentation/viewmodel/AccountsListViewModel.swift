//
//  AccountsListViewModel.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 12/10/2023.
//

import Foundation
import Resolver
import Combine
import BackbaseDesignSystem
import BackbaseObservability

final class AccountsListViewModel: NSObject {
    
    // MARK: - Properties
    @Published private(set) var allAccounts = [AccountUIModel]()
    @Published private(set) var screenState: AccountListScreenState = .loading
    
    var didSelectProduct: ((String) -> Void)?
    
    private var observabilityTracker: BackbaseObservability.Tracker? = Resolver.optional()
    
    // MARK: - Private
    
    private lazy var accountsListUseCase: AccountsListUseCase = {
        guard let useCase = Resolver.optional(AccountsListUseCase.self) else {
            fatalError("AccountsListUseCase needed to continue")
        }
        return useCase
    }()
    
    // MARK: - Methods
    func onEvent(_ event: AccountListScreenEvent) {
        
        publishObservabilityEvents(for: event)
        
        switch event {
        case .getAccounts:
            getAccountSummary(fromEvent: .getAccounts)
        case .refresh:
            getAccountSummary(fromEvent: .refresh)
        case .search(let searchString):
            getAccountSummary(fromEvent: .search(searchString))
        }
    }
    
    private func publishObservabilityEvents(for event: AccountListScreenEvent) {
        switch event {
        case .getAccounts:
            observabilityTracker?.publish(event: AccountsJourney.Tracker.event(forScreen: .accounts))
        case .refresh:
            observabilityTracker?.publish(event: AccountsJourney.Tracker.event(forUserAction: .refresh_accounts))
        case .search:
            observabilityTracker?.publish(event: AccountsJourney.Tracker.event(forUserAction: .search_accounts))
        }
    }
    
    private func getAccountSummary(fromEvent event: AccountListScreenEvent) {
        var query = ""
        
        if case let .search(searchString) = event {
            query = searchString
        }
        
        screenState  = .loading
        
        accountsListUseCase.getAccountSummary {[weak self] result in
            guard let self else {
                return
            }
            
            switch result {
            case let .success(accountsSummaryResponse):
                allAccounts = accountsSummaryResponse
                    .toMapUI()
                    .generateList(query: query)
                
                if allAccounts.isEmpty {
                    screenState = .emptyResults(
                        stateViewConfiguration(
                            for: .noAccounts, primaryAction: {
                                self.onEvent(.refresh)
                            })
                    )
                } else {
                    screenState = .loaded
                }
                
            case let .failure(errorResponse):
                screenState = .hasError(
                    stateViewConfiguration(
                        for: .loadingFailure(errorResponse),
                        primaryAction: {
                            self.onEvent(.refresh)
                        }
                    )
                )
            }
        }
    }
}
