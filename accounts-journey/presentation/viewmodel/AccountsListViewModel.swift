//
//  AccountsJourneyViewModel.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 12/10/2023.
//

import Foundation
import Resolver
import Combine

struct AccountListScreenState {
    let isLoading: Bool = false
    let accountSummary: [String] = []
    let errorIcon: String = ""
}

enum AccountListEvent {
    case getAccounts
    case refresh
    case search(String)
}

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
                self?.accountsSummaryUIModel = accountsSummaryResponse.toMapUI()
            case let .failure(errorResponse):
                self?.output.send(.fetchDidFail(error: errorResponse.error!))
            }
        }
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
