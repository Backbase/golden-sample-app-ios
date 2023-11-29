//
//  AccountDetailsViewController.swift
//  AccountsJourney
//
//  Created by George Nyakundi on 29/11/2023.
//

import UIKit
import BackbaseDesignSystem


final class AccountDetailsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func loadView() {
        super.loadView()
        view.addSubview(label)
        setupLayout()
    }
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupView() {
        view.backgroundColor = DesignSystem.shared.colors.foundation.default
    }
    
    func setupLayout() {
        label.snp.makeConstraints { make in
            make
                .leading
                .trailing
                .top
                .equalToSuperview().inset(DesignSystem.shared.spacer.md)
        }
    }
    
    // TODO: Temporary Solution
    func setTitle(_ text: String) {
        self.label.text = text
    }
}
