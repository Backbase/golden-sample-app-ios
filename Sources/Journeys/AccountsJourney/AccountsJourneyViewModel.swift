//
//  AccountsJourneyViewModel.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 12/10/2023.
//

import Foundation
import Resolver
import Combine

final class AccountsJourneyViewModel {
    // MARK: - Private
    
    private lazy var accountsUsecase: AccountsUseCase = {
        guard let usecase = Resolver.optional(AccountsUseCase.self) else {
            fatalError("AccountsUseCase needed to continue")
        }
        return usecase
    }()
    
    let accountSummarySubject =  CurrentValueSubject<AccountSummary?, Error>(nil)
    
    func getAccountSummary() {
        
        accountsUsecase.getAccountSummary {[weak self] result in
            switch result {
            case let .success(accountsSummaryResponse):
                self?.accountSummarySubject.value = accountsSummaryResponse
                self?.accountSummarySubject.send(completion: .finished)
            case let .failure(errorResponse):
                self?.accountSummarySubject.send(completion: .failure(errorResponse.error!))
            }
        }
    }
    
}
