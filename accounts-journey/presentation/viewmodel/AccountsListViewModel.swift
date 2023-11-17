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

enum AccountListEvent {
    case getAccounts
    case refresh
    case search(String)
}

extension AccountListEvent: Equatable {}

final class AccountsListViewModel: NSObject, ObservableObject {
    
    enum ScreenState {
        case loading
        case loaded
        case emptyResults(StateViewConfiguration)
        case hasError(StateViewConfiguration)
    }
    
    @Published  private(set) public var allAccounts = [AccountUIModel]()
    @Published var screenState: ScreenState = .loading
    
    // MARK: - Private
    
    private lazy var accountsUseCase: AccountsUseCase = {
        guard let useCase = Resolver.optional(AccountsUseCase.self) else {
            fatalError("AccountsUseCase needed to continue")
        }
        return useCase
    }()
    
    func onEvent(_ event: AccountListEvent) {
        switch event {
        case .getAccounts:
            getAccountSummary(fromEvent: .getAccounts)
        case .refresh:
            getAccountSummary(fromEvent: .refresh)
        case .search(let searchString):
            getAccountSummary(fromEvent: .search(searchString))
        }
    }
    
    func getAccountSummary(fromEvent event: AccountListEvent) {
        var query = ""
        
        if case let .search(searchString) = event {
            query = searchString
        }
        
        screenState  = .loading
        
        accountsUseCase.getAccountSummary {[weak self] result in
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
                            for: .noAccounts)
                    )
                } else {
                    screenState = .loaded
                }
                
            case let .failure(errorResponse):
                screenState = .hasError(
                    stateViewConfiguration(
                        for: .loadingFailure(errorResponse)
                    )
                )
            }
        }
    }
    
}
