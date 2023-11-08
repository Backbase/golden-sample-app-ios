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
    
    @Published var allAccounts = [AccountsUiModel]()
    
    var refreshAction : (() -> Void)?

    // MARK: - Private
    
    private lazy var accountsUsecase: AccountsUseCase = {
        guard let usecase = Resolver.optional(AccountsUseCase.self) else {
            fatalError("AccountsUseCase needed to continue")
        }
        return usecase
    }()
    
    
    func onEvent(_ event: AccountListEvent) {
        switch event {
        case .getAccounts:
            getAccountSummary()
        case .refresh:
            getAccountSummary()
        case .search(let string):
            getAccountSummary(query: string)
        }
    }
    
    private func getAccountSummary(query: String = "") {
        
        accountsUsecase.getAccountSummary {[weak self] result in
            switch result {
            case let .success(accountsSummaryResponse):
                self?.allAccounts = accountsSummaryResponse.toMapUI().generateList(query: query)
                self?.refreshAction?()
            case let .failure(errorResponse):
                break
            }
        }
    }
    
}

extension AccountsListViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        self.allAccounts.count
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
        
        let sec = self.allAccounts[indexPath.section]
        let accountItem = sec.products[indexPath.row]
        
        accountListCell.setup(accountItem)
        return accountListCell
    }
   
}
