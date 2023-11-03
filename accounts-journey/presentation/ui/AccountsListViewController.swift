//
//  AccountsListViewController.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 12/10/2023.
//

import UIKit
import Combine
import BackbaseDesignSystem

final class AccountsListViewController: UIViewController {
    
    private var viewModel: AccountsListViewModel?
    private let input: PassthroughSubject<AccountsListViewModel.Input, Never> = .init()
    
    private var cancellables = Set<AnyCancellable>()
   
    private func setupView() {
        view.backgroundColor = DesignSystem.shared.colors.foundation.default
    }
    
//    private let refreshControl = UIRefreshControl()
    
    private lazy var accountsSearchTextView: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Search for accounts"
        textField.adjustsFontForContentSizeCategory = true
        return textField
    }()
    
    private lazy var accountsListTableView: UITableView = {
       let table = UITableView()
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.dataSource = viewModel
        table.tableHeaderView = accountsSearchTextView
//        table.refreshControl = refreshControl
        
        table.registerCell(AccountListItemTableCell.self)
        
        return table
    }()
    
    
    func bind(viewModel: AccountsListViewModel) {
        self.viewModel = viewModel
        
        let _ = viewModel.transform(input: input.eraseToAnyPublisher())
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        title = "My Accounts"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        viewModel?.refreshAction = {
            self.accountsListTableView.reloadData()
        }
        viewModel?.processData()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        input.send(.viewDidAppear)
    }
    
    override func loadView() {
        super.loadView()
        view.addSubview(accountsListTableView)
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            accountsListTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: DesignSystem.shared.spacer.md),
            accountsListTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -DesignSystem.shared.spacer.md),
            accountsListTableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: DesignSystem.shared.spacer.md),
            accountsListTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -DesignSystem.shared.spacer.md)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
