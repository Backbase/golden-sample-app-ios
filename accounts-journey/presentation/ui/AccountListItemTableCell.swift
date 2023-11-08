//
//  AccountListItemTableCell.swift
//  AccountsJourney
//
//  Created by George Nyakundi on 26/10/2023.
//

import UIKit
import Resolver
import BackbaseDesignSystem

final class AccountListItemTableCell: UITableViewCell, Reusable {
    
    var configuration: AccountsJourney.Configuration = Resolver.resolve()
    
    private lazy var accountIconView: IconView = {
        let iconView = IconView()
        let paddingValue = DesignSystem.shared.sizer.sm
        iconView.padding = UIEdgeInsets(
            top: paddingValue,
            left: paddingValue,
            bottom: paddingValue,
            right: paddingValue
        )
        configuration.design.styles.accountIconView(iconView)
        return iconView
    }()
    
    private lazy var accountNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private lazy var stateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    private lazy var accountDetailsStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [accountNameLabel, stateLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = DesignSystem.shared.spacer.sm
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
        label.textAlignment = .right
        return label
    }()
    
    private lazy var mainStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            accountIconView,
            accountDetailsStack,
            accountBalanceLabel]
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = DesignSystem.shared.spacer.xs
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.setCustomSpacing(DesignSystem.shared.spacer.md, after: accountIconView)
        stackView.setCustomSpacing(DesignSystem.shared.spacer.md, after: accountDetailsStack)
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
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            accountIconView.topAnchor.constraint(equalTo: contentView.topAnchor),
            accountIconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            accountIconView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: DesignSystem.shared.spacer.md),
            
            accountIconView.widthAnchor.constraint(equalToConstant: 40),
            accountIconView.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func setup(_ account: AccountUiModel?) {

        if let account {
            let row = configuration.accountRowProvider(account)
            setup(accountIconView, with: row.accountIcon)
            setup(accountNameLabel, with: row.accountName)
            setup(stateLabel, with: row.stateLabel)
            setup(accountBalanceLabel, with: row.accountBalance)
        }
       
        
        configure()
    }
    
    private func setup(_ label: UILabel, with styleableText: AccountsListRowItem.StyleableText?) {
        guard let styleableText else {
            label.isHidden = true
            return
        }
        label.isHidden = false
        switch styleableText {
        case let .text(text, textStyle):
            label.text = text
            textStyle?(label)
        case let .currency(currency, currencyStyle):
            currencyStyle((currency.amount, currency.currencyCode))(label)
        }
    }
    
    private func setup(_ icon: IconView, with accountIconInfo:AccountIconInfo?) {
        guard let accountIconInfo else {
            icon.isHidden = true
            return
        }
        icon.isHidden = false
        icon.image = accountIconInfo.icon
        
        if let iconBackgroundColor = accountIconInfo.backgroundColor {
            icon.backgroundColor = iconBackgroundColor
        }
    }
}
