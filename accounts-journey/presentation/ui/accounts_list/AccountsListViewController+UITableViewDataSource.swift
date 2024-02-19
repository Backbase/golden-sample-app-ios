//
//  AccountsListViewController+UITableViewDataSource.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 17/11/2023.
//

import UIKit

extension AccountsListViewController: UITableViewDataSource {
    private var rowCount: Int {
        return viewModel.allAccounts.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let accountListCell = tableView.dequeReusableCell(AccountListItemTableCell.self)
        let accountItem = viewModel.allAccounts[indexPath.row]
        accountListCell.setupCornerRadius(position: rowPosition(for: indexPath))
        accountListCell.setup(accountItem)
        return accountListCell
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
