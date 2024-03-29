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
    
    private var tracker: BackbaseObservability.Tracker? = Resolver.optional()
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Private
    
    private lazy var accountsListUseCase: AccountsListUseCase = {
        guard let useCase = Resolver.optional(AccountsListUseCase.self) else {
            fatalError("AccountsListUseCase needed to continue")
        }
        return useCase
    }()
    
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
    
    func bind(viewDidAppearPublisher: AnyPublisher<Void, Never>, userActionEventPublisher: AnyPublisher<UserActionEvent, Never>) {
        viewDidAppearPublisher.sink { [weak self] _ in
            self?.tracker?.publish(event: ScreenViewEvent(.accountsList))
        }.store(in: &cancellables)
        
        userActionEventPublisher.sink { [weak self] userActionEvent in
            self?.tracker?.publish(event: userActionEvent)
        }.store(in: &cancellables)
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
