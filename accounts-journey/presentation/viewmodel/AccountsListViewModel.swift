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
        case idle
        case loading
        case loaded
        case emptyResults(StateViewConfiguration)
        case hasError(StateViewConfiguration)
    }
    
    @Published var allAccounts = [AccountUiModel]()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var hasError = false
    var filteredAccounts = [AccountUiModel]()
    
    private let screenStateSubject = CurrentValueSubject<ScreenState, Never>(.idle)
    
    var screenStatePublisher: AnyPublisher<ScreenState, Never> {
        screenStateSubject.eraseToAnyPublisher()
    }

    var reloadListAction : (() -> Void)?
    var startRefreshingAction: (() -> Void)?
    var endRefreshingAction: (() -> Void)?
    var isSearching: Bool = false
    
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
            filterAccountsWith(query: searchString)
        }
    }
    
    func getAccountSummary(fromEvent event: AccountListEvent,  query: String = "") {
        if event == .refresh {
            self.startRefreshingAction?()
        }
        
        screenStateSubject.send(.loading)
        
        accountsUseCase.getAccountSummary {[weak self] result in
            guard let self else { return }
            
            if event == .refresh {
                self.endRefreshingAction?()
            }
            
            switch result {
            case let .success(accountsSummaryResponse):
                self.allAccounts = accountsSummaryResponse.toMapUI().generateList()
                
                if self.allAccounts.isEmpty {
                    self.screenStateSubject.send(
                        .emptyResults(
                            self.stateViewConfiguration(
                                for: .noAccounts
                            )
                        )
                    )
                } else {
                    self.screenStateSubject.send(.loaded)
                }
                
            case let .failure(errorResponse):
                self.screenStateSubject.send(
                    .hasError(
                        self.stateViewConfiguration(
                            for: .loadingFailure(errorResponse)
                        )
                    )
                )
                break
            }
        }
    }
    
    private func filterAccountsWith(query: String = "") {
        self.filteredAccounts = allAccounts
        let q = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        self.filteredAccounts = q.isEmpty ? allAccounts : allAccounts.filter {
            $0.name!.lowercased().contains(q)
        }
        reloadListAction?()
    }
    
}

extension AccountsListViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isSearching ? self.filteredAccounts.count:  self.allAccounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let accountListCell = tableView.dequeReusableCell(AccountListItemTableCell.self)
        
        let accountItem = isSearching ? self.filteredAccounts[indexPath.row] : self.allAccounts[indexPath.row]
        accountListCell.setupSelectedViewCornerRadius(position: rowPosition(for: indexPath))
        
        accountListCell.setup(accountItem)
        return accountListCell
    }
}

extension AccountsListViewModel {
    func rowPosition(for indexPath: IndexPath) -> CellPosition {
        let sectionRows = self.allAccounts
        if sectionRows.count < 2 {
            return .full
        }
        if indexPath.row == 0 {
            return .beginning
        }
        if indexPath.row == sectionRows.count - 1 {
            return .end
        }
        return .middle
    }
}

