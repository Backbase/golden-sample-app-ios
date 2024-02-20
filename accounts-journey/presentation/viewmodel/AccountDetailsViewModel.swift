//
//  AccountDetailsViewModel.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 29/11/2023.
//

import Foundation
import Resolver
import Combine
import BackbaseDesignSystem
import BackbaseObservability

final class AccountDetailsViewModel: NSObject {
    
    // MARK: - Properties
    @Published private(set) var screenState: AccountDetailsScreenState = .loading
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Private
    private lazy var accountDetailsUseCase: AccountDetailsUseCase = {
        guard let useCase = Resolver.optional(AccountDetailsUseCase.self) else {
            fatalError("AccountDetailsUseCase needed to continue")
        }
        return useCase
    }()
    
    private var tracker: BackbaseObservability.Tracker? = Resolver.optional()
    
    // MARK: - Methods
    func onEvent(_ event: AccountDetailsEvent) {
        switch event {
        case let .getAccountDetails(id):
            getAccountDetail(id: id)
        }
    }
    
    func getAccountDetail(id: String) {
        screenState = .loading
        
        accountDetailsUseCase.getAccountDetail(arrangementId: id) {[weak self] result in
            guard let self else {
                return
            }
            
            switch result {
            case let .success(accountDetailsResponse):
                screenState = .loaded( accountDetailsResponse.toMapUI())
            case let .failure(errorResponse):
                screenState = .hasError(
                    stateViewConfiguration(
                        for: .loadingFailure(errorResponse), primaryAction: {
                    self.onEvent(.getAccountDetails(id))
                }))
            }
        }
    }
    
    func bind(viewDidAppear: AnyPublisher<Void, Never>) {
        viewDidAppear.sink { [weak self] _ in
            self?.tracker?.publish(event: ScreenViewEvent(.account_details))
        }.store(in: &cancellables)
    }
}

public enum AccountDetailsEvent {
    case getAccountDetails(String)
}

/// Enum representing the possible states of the AccountDetails screen
public enum AccountDetailsScreenState {
    /// Loading
    case loading
    /// Idle state
    case loaded(AccountDetailsUIModel)
    /// Error has been encountered
    case hasError(StateViewConfiguration)
}
