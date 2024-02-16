//
//  AccountsListViewController+UITableViewDataSource.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 17/11/2023.
//

import UIKit

extension AccountsListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.allAccounts.count + 1 // +1 the Search Cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let searchCell = tableView.dequeReusableCell(SearchBarTableViewCell.self)
            // TODO here bind events
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

            accountListCell.setupSelectedViewCornerRadius(position: rowPosition(for: indexPath))
            accountListCell.setup(accountItem)
            return accountListCell
        }
    }
}

extension AccountsListViewController {
    private func rowPosition(for indexPath: IndexPath) -> CellPosition {
        let sectionRows = viewModel.allAccounts
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
