//
//  AccountListItemTableCell.swift
//  AccountsJourney
//
//  Created by George Nyakundi on 26/10/2023.
//

import UIKit
import BackbaseDesignSystem

final class AccountListItemTableCell: UITableViewCell, Reusable {
    
    private lazy var accountNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var accountStateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var accountBalanceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
        
        [ accountNameLabel, accountStateLabel, accountBalanceLabel, accountIconView ]
            .forEach {
                contentView.addSubview($0)
            }
        
    }
    
    private func layoutViews() {
        
    }
}

