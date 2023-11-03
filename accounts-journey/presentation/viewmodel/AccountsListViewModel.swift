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
    @Published var allAccounts = [AccountsUiModel]()
//    @Published var accc
    
    var refreshAction : (() -> Void)?
    
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
        
        if !accountSummaryResponse.customProducts.isEmpty {
            accountSummaryUIModel.customProducts = accountSummaryResponse.customProducts.map {
                return AccountsUiModel(
                    header: $0.name ?? "",
                    products: $0.products.map {
                        return AccountUiModel(
                            id: $0.identifier,
                            name: $0.name,
                            balance: $0.bookedBalance,
                            state: $0.state?.state,
                            iban: $0.bban ?? $0.bban ?? $0.bic,
                            isVisible: $0.visible,
                            iconName: nil
                        )
                    })
            }
        }
        
        if let currentAccounts = accountSummaryResponse.currentAccounts {
            accountSummaryUIModel.currentAccounts = AccountsUiModel(
                header: currentAccounts.name ?? "",
                products: currentAccounts.products.map {
                    return AccountUiModel(
                        id: $0.identifier,
                        name: $0.name,
                        balance: $0.bookedBalance,
                        state: $0.state?.state,
                        iban: $0.bban ?? $0.bban ?? $0.bic,
                        isVisible: $0.visible,
                        iconName: ""
                    )
                })
        }
        
        
        if let savingsAccounts = accountSummaryResponse.savingsAccounts {
            accountSummaryUIModel.savingAccounts = AccountsUiModel(
                header: savingsAccounts.name ?? "",
                products:  savingsAccounts.products.map {
                    return AccountUiModel(
                        id: $0.identifier,
                        name: $0.name,
                        balance: $0.bookedBalance,
                        state: $0.state?.state,
                        iban: $0.iban,
                        isVisible: $0.visible,
                        iconName: nil
                    )
                })
        }
        
        if let termDeposits = accountSummaryResponse.termDeposits {
            accountSummaryUIModel.termDeposits = AccountsUiModel(
                header: termDeposits.name ?? "",
                products: termDeposits.products.map {
                    return AccountUiModel(
                        id: $0.identifier,
                        name: $0.name,
                        balance: $0.bookedBalance,
                        state: $0.state?.state,
                        iban: $0.iban,
                        isVisible: $0.visible,
                        iconName: nil
                    )
                })
        }
        
        if let loans = accountSummaryResponse.loans {
            accountSummaryUIModel.loans = AccountsUiModel(
                header: loans.name ?? "" ,
                products: loans.products.map {
                    return AccountUiModel(
                        id: $0.identifier,
                        name: $0.name,
                        balance: $0.bookedBalance,
                        state: $0.state?.state,
                        iban: $0.iban,
                        isVisible: $0.visible,
                        iconName: nil
                    )
                })
        }
        
        if let creditCards = accountSummaryResponse.creditCards {
            accountSummaryUIModel.creditCards = AccountsUiModel(
                header: creditCards.name ?? "",
                products: creditCards.products.map {
                    return AccountUiModel(
                        id: $0.identifier,
                        name: $0.name,
                        balance: $0.bookedBalance,
                        state: $0.state?.state,
                        iban: $0.number,
                        isVisible: $0.visible,
                        iconName: nil
                    )
                })
        }
        
        if let debitCards = accountSummaryResponse.debitCards {
            accountSummaryUIModel.debitCards = AccountsUiModel(
                header: debitCards.name ?? "",
                products: debitCards.products.map {
                    return AccountUiModel(
                        id: $0.identifier,
                        name: $0.name,
                        balance: String($0.reservedAmount ?? 0),
                        state: $0.state?.state,
                        iban: $0.number,
                        isVisible: $0.visible,
                        iconName: nil
                    )
                })
        }
        
        if let investmentAccounts = accountSummaryResponse.investmentAccounts {
            accountSummaryUIModel.investmentAccounts = AccountsUiModel(
                header: investmentAccounts.name ?? "",
                products:investmentAccounts.products.map {
                return AccountUiModel(
                    id: $0.identifier,
                    name: $0.name,
                    balance: $0.currentInvestmentValue,
                    state: $0.state?.state,
                    iban: $0.iban,
                    isVisible: $0.visible,
                    iconName: nil
                )
            } )
            
        }
        return accountSummaryUIModel
    }
}

extension AccountsListViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        allAccounts.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sec = self.allAccounts[section]
        return sec.header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sec = self.allAccounts[section]
        return sec.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let accountListCell = tableView.dequeReusableCell(AccountListItemTableCell.self)
        
        
        let sec = allAccounts[indexPath.section]
        let accountItem = sec.products[indexPath.row]
        
        accountListCell.setup(accountItem)
        return accountListCell
    }
    
    func processData() {
        $accountsSummaryUIModel.sink(receiveValue: {[weak self] accountSummaryModel in
            if let  customProducts = accountSummaryModel?.customProducts {
                self?.allAccounts.append(contentsOf: customProducts)
            }
            
            if let currentAccountsUIModel = accountSummaryModel?.currentAccounts,
               !currentAccountsUIModel.products.isEmpty {
                self?.allAccounts.append(currentAccountsUIModel)
            }
            
            if let savingsAccountsUIModel = accountSummaryModel?.savingAccounts,
                !savingsAccountsUIModel.products.isEmpty {
                self?.allAccounts.append(savingsAccountsUIModel)
            }
            
            if let termDepositAccountsUIModel = accountSummaryModel?.termDeposits,
                !termDepositAccountsUIModel.products.isEmpty {
                self?.allAccounts.append(termDepositAccountsUIModel)
            }
            if let creditCardAccountsUIModel = accountSummaryModel?.creditCards,
               !creditCardAccountsUIModel.products.isEmpty {
                self?.allAccounts.append(creditCardAccountsUIModel)
            }
            if let debitCardAccountsUIModel = accountSummaryModel?.debitCards,
               !debitCardAccountsUIModel.products.isEmpty {
                self?.allAccounts.append(debitCardAccountsUIModel)
            }
            if let investmentAccountsUIModel = accountSummaryModel?.investmentAccounts,
               !investmentAccountsUIModel.products.isEmpty {
                self?.allAccounts.append(investmentAccountsUIModel)
            }
            
            self?.refreshAction?()
        })
        .store(in: &cancellables)
    }
}
