//
//  AccountsJourneyViewModel.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 12/10/2023.
//

import Foundation
import Resolver
import Combine

final class AccountsJourneyViewModel {
    
    enum Input {
        case viewDidAppear
        case viewDidRefresh
    }
    
    enum Output {
        case fetchDidFail(error: Error)
        case fetchDidSucceed(accountSummary: AccountsSummary)
    }
    
    // MARK: - Private
    
    private lazy var accountsUsecase: AccountsUseCase = {
        guard let usecase = Resolver.optional(AccountsUseCase.self) else {
            fatalError("AccountsUseCase needed to continue")
        }
        return usecase
    }()
    
    private var cancellables = Set<AnyCancellable>()
    private let output: PassthroughSubject<Output, Never> = .init()
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output,Never> {
        input.sink {[weak self] event in
            switch event {
            case .viewDidAppear, .viewDidRefresh:
                self?.getAccountSummary()
            }
        }.store(in: &cancellables)
        
        return output.eraseToAnyPublisher()
    }
    
    private func getAccountSummary() {
        
        accountsUsecase.getAccountSummary {[weak self] result in
            switch result {
            case let .success(accountsSummaryResponse):
                self?.output.send(.fetchDidSucceed(accountSummary: accountsSummaryResponse))
            case let .failure(errorResponse):
                self?.output.send(.fetchDidFail(error: errorResponse.error! as! Error))
            }
        }
    }
    
}
