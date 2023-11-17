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
import SnapKit

final class AccountsListViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: AccountsListViewModel
    let configuration: AccountsJourney.Configuration = Resolver.resolve()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialisation
    init(viewModel: AccountsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Properties
    private var refreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        return refreshControl
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var stateView: StateView?
    private let loadingView = LoadingView()
    
    private lazy var accountsListTableView: RoundedTableView = {
        let table = RoundedTableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.alwaysBounceVertical = false
        table.dataSource = self
        table.registerCell(AccountListItemTableCell.self)
        table.refreshControl = refreshControl
        
        return table
    }()
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSearchController()
        setupBindings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.onEvent(.getAccounts)
    }
    
    override func loadView() {
        super.loadView()
        view.addSubview(accountsListTableView)
        view.addSubview(loadingView)
        setupLayout()
        
    }
    
    // MARK: - Private methods
    
    @objc private func handleRefreshControl() {
        viewModel.onEvent(.refresh)
    }
    
    private func setupLayout() {
        accountsListTableView.snp.makeConstraints { make in
            make
                .leading
                .trailing
                .bottom
                .equalToSuperview().inset(DesignSystem.shared.spacer.md)
            make.top.equalToSuperview()
        }
        
        loadingView.snp.makeConstraints { make in
            make
                .leading
                .trailing
                .equalToSuperview()
                .inset(DesignSystem.shared.spacer.md)
            make
                .centerY
                .equalToSuperview()
        }
    }
    
    private func setupBindings() {
        searchController
            .textPublisher
            .removeDuplicates()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] in
                self?.viewModel.onEvent(.search($0))
            }.store(in: &cancellables)
        
        viewModel
            .$screenState
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] state in
                self?.removeStateView()
                switch state {
                case .loading:
                    self?.showLoadingView()
                case .loaded:
                    self?.hideLoadingView()
                    self?.accountsListTableView.isHidden = false
                    self?.accountsListTableView.reloadData()
                case let .hasError(stateViewConfig), let .emptyResults(stateViewConfig):
                    self?.hideLoadingView()
                    self?.showStateView(stateViewConfig)
                }
            })
            .store(in: &cancellables)
        
    }
    
    private func setupSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = configuration.strings.searchText()
        navigationItem.searchController = searchController
        definesPresentationContext = false
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        
        configuration.design.styles.searchBar(searchController.searchBar)
    }
    
    private func setupView() {
        view.backgroundColor = DesignSystem.shared.colors.foundation.default
        title = configuration.strings.screenTitle()
        
        if let bar = navigationController?.navigationBar {
            configuration.design.styles.navigationBar(bar)
        }
    }
    
    private func showLoadingView() {
        accountsListTableView.isHidden = true
        loadingView.isHidden = false
        loadingView.startAnimating()
    }
    
    private func hideLoadingView(){
        loadingView.isHidden = true
        loadingView.stopAnimating()
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
        
        stateView.snp.makeConstraints { make in
            make
                .leading
                .trailing
                .equalToSuperview()
                .inset(DesignSystem.shared.spacer.md)
            make
                .centerY
                .equalToSuperview()
        }
    }
    
    private func removeStateView() {
        if stateView != nil {
            UIView.animate(
                withDuration: 0.2,
                animations: {[weak self] in
                    self?.stateView?.alpha = 0.0
                },
                completion: {[weak self] _ in
                    self?.stateView?.removeFromSuperview()
                    self?.stateView = nil
                })
        }
    }
}

// MARK: - Extensions
extension AccountsListViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.onEvent(.search(""))
    }
}
