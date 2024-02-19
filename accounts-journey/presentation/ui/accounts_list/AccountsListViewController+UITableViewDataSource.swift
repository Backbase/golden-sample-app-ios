//
//  AccountsListViewController+UITableViewDataSource.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 17/11/2023.
//

import UIKit

extension AccountsListViewController: UITableViewDataSource {

    // +1 the Search Cell
    private var rowCount: Int {
        let accountsCount = viewModel.allAccounts.count
        if firstTimeLoad {
            return accountsCount == 0 ? 0 : (accountsCount + 1)
        } else {
            return accountsCount + 1
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let searchCell = tableView.dequeReusableCell(AccountListSearchTableCell.self)
            searchCell.setupCornerRadius(position: rowPosition(for: indexPath))
            // TODO here bind cancel events
            // TODO cancel the previous bindings
            searchCell.searchBar
                .textPublisher
                .removeDuplicates()
                .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
                .sink { [weak self] in
                    self?.viewModel.onEvent(.search($0))
                }.store(in: &cancellables)

            return searchCell
        } else {
            let accountListCell = tableView.dequeReusableCell(AccountListItemTableCell.self)
            let accountItem = viewModel.allAccounts[indexPath.row - 1]
            accountListCell.setupCornerRadius(position: rowPosition(for: indexPath))
            accountListCell.setup(accountItem)
            return accountListCell
        }
    }
}

extension AccountsListViewController {
    private func rowPosition(for indexPath: IndexPath) -> CellPosition {
        if rowCount < 2 {
            return .full
        }
        if indexPath.row == 0 {
            return .beginning
        }
        if indexPath.row == rowCount - 1 {
            return .end
        }
        return .middle
    }
}
