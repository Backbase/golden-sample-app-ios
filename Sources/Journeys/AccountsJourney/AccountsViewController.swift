//
//  AccountsViewController.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 12/10/2023.
//

import UIKit
import Combine

final class AccountsViewController: ViewController {
    
    private var viewModel: AccountsJourneyViewModel?
    
    private var cancellables: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(label)
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "HELLO WORLD!"
        label.font = UIFont.systemFont(ofSize: 48)
        label.textAlignment = .center
        return label
    }()
    
    func bind(viewModel: AccountsJourneyViewModel) {
        self.viewModel = viewModel
    
        cancellables = viewModel.accountSummarySubject.sink {[weak self] completion in
            switch completion {
            case .finished:
                self?.label.text = "Finished loading"
            case let .failure(error):
                self?.label.text = error.localizedDescription
            }
        } receiveValue: { [weak self ] accountSummary in
            self?.label.text = "I"
            print(accountSummary)
        }

    }

}
