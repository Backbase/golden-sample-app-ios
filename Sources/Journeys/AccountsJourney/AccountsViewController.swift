//
//  AccountsViewController.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 12/10/2023.
//

import UIKit
import Combine

final class AccountsViewController: UIViewController {
    
    private var viewModel: AccountsJourneyViewModel?
    private let input: PassthroughSubject<AccountsJourneyViewModel.Input, Never> = .init()
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        input.send(.viewDidAppear)
    }
    
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 48)
        label.textAlignment = .center
        return label
    }()
    
    private func setupLabel() {
        view.backgroundColor = .white
        view.addSubview(label)
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func bind(viewModel: AccountsJourneyViewModel) {
        self.viewModel = viewModel
        
        let output = viewModel.transform(input: input.eraseToAnyPublisher())
        output
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                switch event {
                case let .fetchDidFail(error):
                    self?.label.text = error.localizedDescription
                case let .fetchDidSucceed(accountSummary):
                    self?.label.text = accountSummary.currentAccounts?.product[0].accountHolderNames ?? ""
                }
            }.store(in: &cancellables)
    }

}
