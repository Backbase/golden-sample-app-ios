//
//  AccountsListViewController.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 12/10/2023.
//

import UIKit
import Combine
import BackbaseObservability
import Resolver
import BackbaseDesignSystem

final class AccountsListViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: AccountsListViewModel
    private let configuration: AccountsJourney.Configuration = Resolver.resolve()
    private var cancellables = Set<AnyCancellable>()
    private let headerView = AccountListSearchBarHeaderView()
    private let viewDidAppearSubject = PassthroughSubject<Void, Never>()
    private let userActionEventSubject = PassthroughSubject<UserActionEvent, Never>()

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
        refreshControl.translatesAutoresizingMaskIntoConstraints = false
        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        return refreshControl
    }

    private var stateView: StateView?
    
    private let loadingView: LoadingView = {
        let view = LoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var accountsListTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
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
        headerView.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewDidAppearSubject.send()
    }

    // MARK: - Private methods
    
    @objc private func handleRefreshControl() {
        viewModel.onEvent(.refresh)
        userActionEventSubject.send(UserActionEvent(.refreshAccounts))
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            accountsListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: DesignSystem.shared.spacer.md),
            accountsListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -DesignSystem.shared.spacer.md),
            accountsListTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            accountsListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: DesignSystem.shared.spacer.md),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -DesignSystem.shared.spacer.md),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupBindings() {
        headerView.textChangeSubject
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink(receiveValue: { [weak self] text in
                self?.viewModel.onEvent(.search(text))
            }).store(in: &cancellables)

        viewModel.bind(
            viewDidAppearPublisher: viewDidAppearSubject.eraseToAnyPublisher(),
            userActionEventPublisher: userActionEventSubject.eraseToAnyPublisher()
        )

        viewModel
            .$screenState
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] state in
                self?.removeStateView()
                self?.accountsListTableView.refreshControl?.endRefreshing()
                switch state {
                case .loading:
                    self?.showLoadingView()
                case .loaded:
                    self?.headerView.isHidden = false
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
        
        view.backgroundColor = Theme.colors.background.page
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
            NSLayoutConstraint.activate([
                stateView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                stateView.centerYAnchor.constraint(equalTo: view.superview!.centerYAnchor)
            ])
        } else {
            // HIDE TABLE
            accountsListTableView.isHidden = true
            // Add state view to the view hierarchy
            view.addSubview(stateView)
            
            NSLayoutConstraint.activate([
                stateView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: DesignSystem.shared.spacer.md),
                stateView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -DesignSystem.shared.spacer.md),
                stateView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        }
    }
    
    private func removeStateView() {
        stateView?.removeFromSuperview()
        stateView = nil
    }
}
