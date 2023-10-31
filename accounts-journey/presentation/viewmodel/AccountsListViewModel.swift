//
//  AccountsJourneyViewModel.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 12/10/2023.
//

import Foundation
import Resolver
import Combine

final class AccountsListViewModel: NSObject, ObservableObject {
    
    @Published private(set) var accountsSummaryUIModel: AccountSummaryUiModel?
    
    enum Input {
        case viewDidAppear
        case viewDidRefresh
    }
    
    enum Output {
        case fetchDidFail(error: Error)
        case fetchDidSucceed(accountSummary: AccountsJourney.AccountsSummary)
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
                self?.accountsSummaryUIModel = self?.toUIModel(accountsSummaryResponse)
            case let .failure(errorResponse):
                self?.output.send(.fetchDidFail(error: errorResponse.error!))
            }
        }
    }
    
}

extension AccountsListViewModel  {
    func toUIModel(_ accountSummaryResponse: AccountsJourney.AccountsSummary ) -> AccountSummaryUiModel {
        var accountSummaryUIModel = AccountSummaryUiModel()
        
        let customProducts = accountSummaryResponse.customProducts
        
        if !customProducts.isEmpty {
            accountSummaryUIModel.customProducts = customProducts.map {
                return AccountsUiModel(header: $0.name, products: $0.products.map {
                    return AccountUiModel(id: $0.identifier, name: $0.name, balance: $0.bookedBalance, state: $0.state?.state, iban: $0.iban ?? $0.bban ?? $0.bic, isVisible: $0.visible, iconName: nil)
                })
            }
        }
        
        if let currentAccounts = accountSummaryResponse.currentAccounts {
            accountSummaryUIModel.currentAccounts?.header = currentAccounts.name
            accountSummaryUIModel.currentAccounts?.products = currentAccounts.products.map {
                return AccountUiModel(id: $0.identifier, name: $0.name, balance: $0.bookedBalance, state: $0.state?.state, iban: $0.iban, isVisible: $0.visible, iconName: nil)
            }
        }
        if let savingsAccounts = accountSummaryResponse.savingsAccounts {
            accountSummaryUIModel.savingAccounts?.header = savingsAccounts.name
            accountSummaryUIModel.savingAccounts?.products = savingsAccounts.product.map {
                return AccountUiModel(id: $0.identifier, name: $0.name, balance: $0.bookedBalance, state: $0.state?.state, iban: $0.iban, isVisible: $0.visible, iconName: nil)
            }
        }
        if let termDeposits = accountSummaryResponse.termDeposits {
            accountSummaryUIModel.termDeposits?.header = termDeposits.name
            accountSummaryUIModel.termDeposits?.products = termDeposits.products.map {
                return AccountUiModel(id: $0.identifier, name: $0.name, balance: $0.bookedBalance, state: $0.state?.state, iban: $0.iban, isVisible: $0.visible, iconName: nil)
            }
        }
        if let loans = accountSummaryResponse.loans {
            accountSummaryUIModel.loans?.header = loans.name
            accountSummaryUIModel.loans?.products = loans.products.map {
                return AccountUiModel(id: $0.identifier, name: $0.name, balance: $0.bookedBalance, state: $0.state?.state, iban: $0.iban, isVisible: $0.visible, iconName: nil)
            }
        }
        if let creditCards = accountSummaryResponse.creditCards {
            accountSummaryUIModel.creditCards?.header = creditCards.name
            accountSummaryUIModel.creditCards?.products = creditCards.products.map {
                return AccountUiModel(id: $0.identifier, name: $0.name, balance: $0.bookedBalance, state: $0.state?.state, iban: $0.number, isVisible: $0.visible, iconName: nil)
            }
        }
        if let debitCards = accountSummaryResponse.debitCards {
            accountSummaryUIModel.debitCards?.header = debitCards.name
            accountSummaryUIModel.debitCards?.products = debitCards.products.map {
                return AccountUiModel(id: $0.identifier, name: $0.name, balance: String($0.reservedAmount ?? 0), state: $0.state?.state, iban: $0.number, isVisible: $0.visible, iconName: nil)
            }
        }
        if let investmentAccounts = accountSummaryResponse.investmentAccounts {
            accountSummaryUIModel.investmentAccounts?.header = investmentAccounts.name
            accountSummaryUIModel.investmentAccounts?.products = investmentAccounts.products.map {
                return AccountUiModel(id: $0.identifier, name: $0.name, balance: $0.currentInvestmentValue, state: $0.state?.state, iban: $0.iban, isVisible: $0.visible, iconName: nil)
            }
        }
        return accountSummaryUIModel
    }
}

extension AccountsListViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let accountListCell = tableView.dequeReusableCell(AccountListItemTableCell.self)
        
        var allAccounts = [AccountUiModel]()
        
        $accountsSummaryUIModel.sink(receiveValue: {accountSummaryModel in
            if let  customProducts = accountSummaryModel?.customProducts {
                for customProduct in customProducts {
                    allAccounts.append(contentsOf: customProduct.products.map {
                        $0
                    })
                }
            }
            
            if !allAccounts.isEmpty {
                let accountItem = allAccounts[indexPath.row]
                accountListCell.setup(accountItem)
            }

        })
        .store(in: &cancellables)
       
        return accountListCell
    }
}
