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
        return viewModel.allAccounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let accountListCell = tableView.dequeReusableCell(AccountListItemTableCell.self)
        
        let accountItem = viewModel.allAccounts[indexPath.row]
        
        accountListCell.setupSelectedViewCornerRadius(position: rowPosition(for: indexPath))
        accountListCell.setup(accountItem)
        return accountListCell
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
