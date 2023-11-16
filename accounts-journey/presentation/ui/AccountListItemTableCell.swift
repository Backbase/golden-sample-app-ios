//
//  AccountListItemTableCell.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 26/10/2023.
//

import UIKit
import Resolver
import SnapKit
import BackbaseDesignSystem

final class AccountListItemTableCell: UITableViewCell, Reusable {
    
    var configuration: AccountsJourney.Configuration = Resolver.resolve()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = DesignSystem.shared.sizer.sm
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = DesignSystem.shared.sizer.xs
        return stackView
    }()
    
    private lazy var accountNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    private lazy var accountStateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    private lazy var accountBalanceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    
    private lazy var accountIconView: IconView = {
        let iconView = IconView()
        iconView.translatesAutoresizingMaskIntoConstraints = false
        configuration.design.styles.accountIconView(iconView)
        return iconView
    }()
    
    private lazy var accountDetailsStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [accountNameLabel, accountStateLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = DesignSystem.shared.spacer.sm
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        accountNameLabel.text = ""
        accountStateLabel.text = ""
        accountBalanceLabel.text = ""
        selectionStyle = .none
    }
    
    private func setupSubviews() {
        contentView.addSubview(containerStackView)
        contentView.backgroundColor = .clear
        backgroundColor = DesignSystem.shared.colors.surfacePrimary.default
        containerStackView.addArrangedSubview(accountIconView)
        containerStackView.addArrangedSubview(infoStackView)
        infoStackView.addArrangedSubview(accountNameLabel)
        infoStackView.addArrangedSubview(accountStateLabel)
        infoStackView.addArrangedSubview(accountBalanceLabel)
        
        containerStackView.snp.makeConstraints { make in
            make
                .leading
                .top
                .trailing
                .bottom
                .equalToSuperview().inset(DesignSystem.shared.spacer.md)
        }
        
    }
    
    func setupSelectedViewCornerRadius(position: CellPosition) {
        let view = UIView()
        let color = UIColor(light: DesignSystem.shared.colors.primary.lightest, dark: DesignSystem.shared.colors.primary.darkest)
        view.backgroundColor = color
        view.layer.cornerRadius = DesignSystem.shared.cornerRadius.large
        view.layer.maskedCorners = position.maskedCorners
        selectedBackgroundView = view
        
        layer.cornerRadius = DesignSystem.shared.cornerRadius.large
        layer.maskedCorners = position.maskedCorners
    }
    
    
    func setup(_ account: AccountUIModel?) {

        if let account {
            let row = configuration.accountRowProvider(account)
            setup(accountIconView, with: row.accountIcon)
            setup(accountNameLabel, with: row.accountName)
            setup(accountStateLabel, with: row.stateLabel)
            setup(accountBalanceLabel, with: row.accountBalance)
        }
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

internal enum CellPosition {
    case beginning
    case end
    case middle
    case full
    
    internal var cornerRadius: CGFloat {
        self == .middle ? 0 : DesignSystem.shared.cornerRadius.large
    }
    
    internal var maskedCorners: CACornerMask {
        switch self {
        case .beginning:
            return [
                .layerMinXMinYCorner,
                .layerMaxXMinYCorner
            ]
        case .end:
            return [
                .layerMinXMaxYCorner,
                .layerMaxXMaxYCorner
            ]
        case .full:
            return [
                .layerMinXMinYCorner,
                .layerMaxXMinYCorner,
                .layerMinXMaxYCorner,
                .layerMaxXMaxYCorner
            ]
        default:
            return []
        }
    }
}
