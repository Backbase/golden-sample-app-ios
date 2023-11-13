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
    
    private var refreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        return refreshControl
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var stateView: StateView?
   
    private lazy var accountsListTableView: RoundedTableView = {
        let table = RoundedTableView(frame:.zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.clipsToBounds = true
        table.separatorStyle = .none
        table.backgroundColor = .clear
        table.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: DesignSystem.shared.spacer.lg, right: 0)
        table.showsVerticalScrollIndicator = false
        table.alwaysBounceVertical = false
        table.dataSource = viewModel
        table.registerCell(AccountListItemTableCell.self)
        table.refreshControl = refreshControl
        
        return table
    }()
    
    func bind(viewModel: AccountsListViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSearchController()
        setupViewModel()
        setupBindings()
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
        ])
    }
    
    @objc func handleRefreshControl() {
        viewModel?.onEvent(.refresh)
    }
    
    private func setupBindings() {
        viewModel?
            .screenStatePublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] state in
                switch state {
                case .idle:
                    return
                case .loading:
                    self?.beginRefreshing()
                case .loaded:
                    self?.endRefreshing()
                    self?.accountsListTableView.reloadData()
                    // TODO:
                    // Show TableView
                    // Hide loading view
                    // Hide StateView
                case let .hasError(stateViewConfig):
                    // Show Error View
                    self?.showStateView(stateViewConfig)
                case let .emptyResults(stateViewConfig):
                    // Show Empty View
                    self?.showStateView(stateViewConfig)
                }
            })
            .store(in: &cancellables)
    }
    
    private func setupSearchController() {
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = configuration.strings.searchText()
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupView() {
        view.backgroundColor = DesignSystem.shared.colors.foundation.default
        title = configuration.strings.screenTitle()
        
        if let bar = navigationController?.navigationBar {
            configuration.design.styles.navigationBar(bar)
        }
    }
    
    private func setupViewModel() {
        
        viewModel?.reloadListAction = {
            self.accountsListTableView.reloadData()
        }
        
        searchController.textPublisher.sink { [weak self] in
            self?.viewModel?.onEvent(.search($0))
            self?.viewModel?.isSearching = self?.searchController.isActive ?? false
        }.store(in: &cancellables)
    }
    
    private func beginRefreshing() {
        self.accountsListTableView.refreshControl?.isHidden = false
        self.accountsListTableView.refreshControl?.beginRefreshing()
    }
    private func endRefreshing() {
        self.accountsListTableView.refreshControl?.isHidden = true
        self.accountsListTableView.refreshControl?.endRefreshing()
    }
    
    private func showStateView(_ configuration: StateViewConfiguration) {
        stateView = StateView(
            params: StateViewInitParams(
                configuration: configuration,
                bundles: .accountsJourney ?? .design ?? .main
            )
        )
        
        guard let stateView else { return }
        stateView.accessibilityIdentifier = "AccountsListStateView"
        // HIDE TABLE
        accountsListTableView.isHidden = true
        // Add state view to the view hierarchy
        view.addSubview(stateView)
        // Specify StateView Constraints
        NSLayoutConstraint.activate([
            stateView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: DesignSystem.shared.spacer.md),
            stateView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -DesignSystem.shared.spacer.md),
            stateView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func removeStateView() {
        if stateView != nil {
            stateView?.removeFromSuperview()
            stateView = nil
        }
    }
    
}
