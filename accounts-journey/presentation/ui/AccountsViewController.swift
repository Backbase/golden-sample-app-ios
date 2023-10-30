//
//  AccountsViewController.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 12/10/2023.
//

import UIKit
import Combine
import BackbaseDesignSystem

final class AccountsViewController: UIViewController {
    
    private var viewModel: AccountsListViewModel?
    private let input: PassthroughSubject<AccountsListViewModel.Input, Never> = .init()
    
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var mainTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "My accounts\nGeorge"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    private let refreshControl = UIRefreshControl()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.alwaysBounceVertical = true
        
        view.addSubview(mainTitleLabel)
        view.addSubview(statusLabel)
        view.refreshControl = refreshControl
        view.contentInset = .init(top: DesignSystem.shared.spacer.sm, left: 0, bottom: 0, right: 0)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private func setupView() {
        view.backgroundColor = DesignSystem.shared.colors.foundation.default
        view.addSubview(scrollView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0),
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0),
            
            mainTitleLabel.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor, constant: DesignSystem.shared.spacer.lg),
            mainTitleLabel.trailingAnchor.constraint(
                equalTo: scrollView.trailingAnchor, constant: -DesignSystem.shared.spacer.lg),
            mainTitleLabel.topAnchor.constraint(
                equalTo: scrollView.topAnchor, constant: DesignSystem.shared.spacer.lg),
            
            statusLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: DesignSystem.shared.spacer.lg),
            statusLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -DesignSystem.shared.spacer.lg),
            statusLabel.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor, constant: DesignSystem.shared.spacer.lg),
        ])
    }
    
    
    func bind(viewModel: AccountsListViewModel) {
        self.viewModel = viewModel
        
        let output = viewModel.transform(input: input.eraseToAnyPublisher())
        output
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                self?.refreshControl.endRefreshing()
                switch event {
                case let .fetchDidFail(error):
                    self?.statusLabel.text = error.localizedDescription
                case let .fetchDidSucceed(accountSummary):
                    let currentAccounts = accountSummary.currentAccounts?.name ?? "Current Accounts"
                    let currentAccountsBalance = accountSummary.currentAccounts?.aggregatedBalance?.value ?? "0"
                    self?.statusLabel.text = currentAccounts + " Balance: " + currentAccountsBalance
                }
            }.store(in: &cancellables)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        input.send(.viewDidAppear)
    }
    

}

#if DEBUG
import SwiftUI

struct AccountsViewPreview: PreviewProvider {
    static var previews: some View {
        AccountsViewController().toPreview()
    }
}
#endif
