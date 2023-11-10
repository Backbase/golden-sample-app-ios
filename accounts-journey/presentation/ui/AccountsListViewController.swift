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
    
    private let refreshControl = UIRefreshControl()
    
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
        
        viewModel?.refreshAction = {
            self.accountsListTableView.reloadData()
        }
        
        searchController.textPublisher.sink { [weak self] in
            self?.viewModel?.onEvent(.search($0))
        }.store(in: &cancellables)
        
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
        ])
    }
    
    private func setupSearchController() {
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = configuration.strings.searchText()
        
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
}
//
//#if DEBUG
//import SwiftUI
//
//struct AccountsListViewPreview: PreviewProvider {
//    static var previews: some View {
//        AccountsListViewController().toPreview()
//    }
//}
//#endif

class RoundedTableView: UITableView {
    private var tableViewBackView: Card?
    private var tableContentObserver: NSKeyValueObservation?
    private var topConstraint: NSLayoutConstraint?
    private var bottomConstraint: NSLayoutConstraint?
    
    let placeHolderHeader = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal override init(frame: CGRect = .zero, style: UITableView.Style = .plain) {
        super.init(frame: frame, style: style)
        // Default views (Needed for the background view)
        tableHeaderView = placeHolderHeader
        tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
    }
    
    override var isHidden: Bool {
        willSet {
            if newValue {
                tableViewBackView?.removeFromSuperview()
            } else {
                adjustTableViewBackView()
            }
        }
    }
    
    override var tableFooterView: UIView? {
        didSet {
            adjustTableViewBackView()
        }
    }
    
    override var tableHeaderView: UIView? {
        didSet {
            adjustTableViewBackView()
        }
    }
    
    private func adjustTableViewBackView() {
        
        if tableViewBackView?.superview != nil {
            tableViewBackView?.removeFromSuperview()
        }
        
        let backViewCard = Card()
        DesignSystem.shared.styles.cardView(backViewCard)
        backViewCard.backgroundColor = DesignSystem.shared.colors.surfacePrimary.default
        
        guard let superView = superview, let footer = tableFooterView, let header = tableHeaderView else { return }
        
        superView.insertSubview(backViewCard, belowSubview: self)
        
        backViewCard.translatesAutoresizingMaskIntoConstraints = false
        backViewCard.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backViewCard.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        topConstraint = backViewCard.topAnchor.constraint(equalTo: header.topAnchor)
        topConstraint?.isActive = true
        
        bottomConstraint = backViewCard.bottomAnchor.constraint(equalTo: footer.topAnchor)
        bottomConstraint?.isActive = true
        
        self.tableViewBackView = backViewCard
    }
}

