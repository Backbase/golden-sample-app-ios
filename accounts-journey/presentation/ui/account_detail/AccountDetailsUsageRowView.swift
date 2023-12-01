//
//  AccountDetailsUsageRowView.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 01/12/2023.
//

import UIKit
import BackbaseDesignSystem

final class AccountDetailsUsageRowView: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = DesignSystem.shared.spacer.sm
        return view
    }()
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        addSubview(stackView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(_ rowItem: AccountDetailsRowItem) {
        switch rowItem.title {
        case .text(let string, let style):
            titleLabel.text = string
            style?(titleLabel)
        case .currency(let currency, let currencyStyle):
            currencyStyle((currency.amount, currency.currencyCode))(titleLabel)
        }
        
        switch rowItem.subTitle {
        case .text(let string, let style):
            subtitleLabel.text = string
            style?(subtitleLabel)
        case .currency(let currency, let currencyStyle):
            currencyStyle((currency.amount, currency.currencyCode))(subtitleLabel)
        }
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
