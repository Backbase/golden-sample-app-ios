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
    var cancellables = Set<AnyCancellable>()

    private let headerView = AccountListSearchBarView()

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

    private var stateView: StateView?
    private let loadingView = LoadingView()
    
    private lazy var accountsListTableView: UITableView = {
        let table = UITableView()
        let inset = DesignSystem.shared.spacer.md
        table.contentInset = UIEdgeInsets(top: inset, left: 0, bottom: inset, right: 0)
        table.alwaysBounceVertical = false
        table.dataSource = self
        table.delegate = self
        table.registerCell(AccountListItemTableCell.self)
        table.tableHeaderView = headerView
        table.refreshControl = refreshControl

        table.clipsToBounds = true
        table.separatorStyle = .none
        table.backgroundColor = .clear
        table.showsVerticalScrollIndicator = false
        table.alwaysBounceVertical = false
        return table
    }()
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
        viewModel.onEvent(.getAccounts)
    }

    // MARK: - Private methods
    
    @objc private func handleRefreshControl() {
        viewModel.onEvent(.refresh)
    }
    
    private func setupLayout() {
        accountsListTableView.snp.makeConstraints { make in
            make.trailing.left
                .equalToSuperview()
                .inset(DesignSystem.shared.spacer.md)
            make.top.bottom.equalTo(view.layoutMarginsGuide)
        }
        
        loadingView.snp.makeConstraints { make in
            make.leading.trailing
                .equalToSuperview()
                .inset(DesignSystem.shared.spacer.md)
            make.centerY
                .equalToSuperview()
        }
    }
    
    private func setupBindings() {
        viewModel
            .$screenState
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] state in
                self?.removeStateView()
                self?.accountsListTableView.refreshControl?.endRefreshing()
                switch state {
                case .loading:
                    self?.showLoadingView()

                    self?.headerView.cancellable = self?.headerView.textChangeSubject
                        .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
                        .sink(receiveValue: { [weak self] text in
                            self?.viewModel.onEvent(.search(text))
                        })
                case .loaded:
                    self?.hideLoadingView()
                    self?.accountsListTableView.isHidden = false
                    self?.accountsListTableView.reloadData()
                case let .hasError(stateViewConfig):
                    self?.accountsListTableView.reloadData()
                    self?.hideLoadingView()
                    self?.showStateView(stateViewConfig, isEmptyState: false)
                case let .emptyResults(stateViewConfig):
                    self?.accountsListTableView.reloadData()
                    self?.hideLoadingView()
                    self?.showStateView(stateViewConfig, isEmptyState: true)
                }
            })
            .store(in: &cancellables)
    }
    
    private func setupView() {
        view.addSubview(accountsListTableView)
        view.addSubview(loadingView)
        setupLayout()
        
        view.backgroundColor = DesignSystem.shared.colors.foundation.default
        title = configuration.accountsList.strings.screenTitle()
        
        if let bar = navigationController?.navigationBar {
            configuration.design.styles.navigationBar(bar)
        }
    }
    
    private func showLoadingView() {
        loadingView.isHidden = false
        loadingView.startAnimating()
    }
    
    private func hideLoadingView(){
        loadingView.isHidden = true
        loadingView.stopAnimating()
    }
    
    private func showStateView(_ configuration: StateViewConfiguration, isEmptyState: Bool) {
        stateView = StateView(
            params: StateViewInitParams(
                configuration: configuration,
                bundles: .accountsJourney ?? .design ?? .main
            )
        )

        guard let stateView else { return }
        stateView.accessibilityIdentifier = "AccountsListStateView"

        // Add state view to the view hierarchy
        if isEmptyState {
            accountsListTableView.addSubview(stateView)
            stateView.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
        } else {
            // HIDE TABLE
            accountsListTableView.isHidden = true
            // Add state view to the view hierarchy
            view.addSubview(stateView)

            stateView.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview()
                    .inset(DesignSystem.shared.spacer.md)
                make.centerY.equalToSuperview()
            }
        }
    }
    
    private func removeStateView() {
        stateView?.removeFromSuperview()
        stateView = nil
    }
}
