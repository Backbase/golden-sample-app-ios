//
//  AccountsListViewController+UITableViewDelegate.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 29/11/2023.
//

import UIKit

extension AccountsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let accountItem = viewModel.allAccounts[indexPath.row]
        if let id = accountItem.id {
            viewModel.didSelectProduct?(id)
        }
    }
}
