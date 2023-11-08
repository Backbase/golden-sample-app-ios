//
//  AccountsListViewController.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 12/10/2023.
//

import UIKit
import Combine
import Resolver
import BackbaseDesignSystem

final class AccountsListViewController: UIViewController {
    
    private var viewModel: AccountsListViewModel?
    
    let configuration: AccountsJourney.Configuration = Resolver.resolve()
    private var cancellables = Set<AnyCancellable>()
    
    //    private let refreshControl = UIRefreshControl()
    
    private lazy var accountsSearchTextView: TextInput = {
        let textField = TextInput()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textField.placeholder = configuration.strings.searchText()
        textField.textField.adjustsFontForContentSizeCategory = true
        DesignSystem.shared.styles.searchInput(textField)
        return textField
    }()
    
    private lazy var accountsListTableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.dataSource = viewModel
        table.tableHeaderView = accountsSearchTextView
        table.registerCell(AccountListItemTableCell.self)
        DesignSystem.shared.styles.tableView(table)
        // TODO: - Fix me
        table.estimatedRowHeight = 80
        table.rowHeight = UITableView.automaticDimension
        
        //        table.refreshControl = refreshControl
        
        return table
    }()
    
    func bind(viewModel: AccountsListViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        viewModel?.refreshAction = {
            self.accountsListTableView.reloadData()
        }
        
        accountsSearchTextView.textPublisher
            .sink {[weak self] in
                self?.viewModel?.onEvent(.search($0))
            }
            .store(in: &cancellables)
    }
    
    private func setupView() {
        view.backgroundColor = DesignSystem.shared.colors.foundation.default
        title = configuration.strings.screenTitle()
        
        if let bar = navigationController?.navigationBar {
            configuration.design.styles.navigationBar(bar)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel?.onEvent(.getAccounts)
    }
    
    override func loadView() {
        super.loadView()
        view.addSubview(accountsListTableView)
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            accountsListTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: DesignSystem.shared.spacer.md),
            accountsListTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -DesignSystem.shared.spacer.md),
            accountsListTableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: DesignSystem.shared.spacer.md),
            accountsListTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -DesignSystem.shared.spacer.md),
            accountsSearchTextView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: DesignSystem.shared.spacer.md),
            accountsSearchTextView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,constant: -DesignSystem.shared.spacer.md),
            accountsSearchTextView.topAnchor.constraint(equalTo: accountsListTableView.topAnchor),
        ])
    }
}

#if DEBUG
import SwiftUI

struct AccountsListViewPreview: PreviewProvider {
    static var previews: some View {
        AccountsListViewController().toPreview()
    }
}
#endif
