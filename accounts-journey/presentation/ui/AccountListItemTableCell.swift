//
//  AccountListItemTableCell.swift
//  AccountsJourney
//
//  Created by George Nyakundi on 26/10/2023.
//

import UIKit
import BackbaseDesignSystem

final class AccountListItemTableCell: UITableViewCell, Reusable {
    
    private lazy var accountIconView: IconView = {
        let iconView = IconView()
        let paddingValue = DesignSystem.shared.sizer.sm
        iconView.padding = UIEdgeInsets(
            top: paddingValue,
            left: paddingValue,
            bottom: paddingValue,
            right: paddingValue
        )
        return iconView
    }()
    
    private lazy var accountNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    private lazy var ibanLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()

    private lazy var accountDetailsStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [accountNameLabel, ibanLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10.0
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var accountBalanceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    private lazy var accountBalanceStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [accountBalanceLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10.0
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var mainStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [accountIconView, accountDetailsStack, accountBalanceStack])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10.0
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        return stackView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addSubviews()
        layoutViews()
    }
    
    private func addSubviews() {
        contentView.subviews.forEach { $0.removeFromSuperview()}
        contentView.addSubview(mainStack)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setup(_ account: AccountUiModel?) {
        if let name = account?.name {
            accountNameLabel.text = name
        }
        if let iban = account?.iban {
            ibanLabel.text = iban
        }
        
        if let iconName = account?.iconName {
            accountIconView.image = UIImage(named: iconName)
        }
        
        if let accountBalance = account?.balance {
            accountBalanceLabel.text = accountBalance
        }
        
        configure()
    }
}
