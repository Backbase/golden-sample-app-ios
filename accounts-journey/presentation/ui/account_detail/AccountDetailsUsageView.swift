//
//  AccountDetailsUsageView.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 01/12/2023.
//

import UIKit
import Resolver
import SnapKit
import BackbaseDesignSystem

final class AccountDetailsUsageView: UIView {
    // MARK: - Properties
    let configuration: AccountsJourney.Configuration = Resolver.resolve()
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [])
        view.axis = .vertical
        view.alignment = .fill
        view.spacing = DesignSystem.shared.spacer.md
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var card: Card = {
        let card = Card(DesignSystem.shared.styles.cardView)
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
    }()
    
    // MARK: - Init
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        addSubview(card)
        card.addSubview(stackView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func updateView(with section: AccountDetailsSection) {
        if let title = section.title {
            titleLabel.text = title.uppercased()
            configuration.accountDetails.design.styles.accountDetailSectionTitle(titleLabel)
        }
        
        for item in section.rows {
            let accountDetailUsageRow = AccountDetailsUsageRowView()
            accountDetailUsageRow.setupView(item)
            stackView.addArrangedSubview(accountDetailUsageRow)
        }
    }
    
    // MARK: - Private Methods
    private func setupConstraints() {
//        guard let superview = self.superview else { return }
        

        NSLayoutConstraint.activate([
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: DesignSystem.shared.spacer.lg),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -DesignSystem.shared.spacer.lg),
            
            // Card
            card.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: DesignSystem.shared.spacer.xs),
            card.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: DesignSystem.shared.spacer.md),
            card.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -DesignSystem.shared.spacer.md),
            card.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -DesignSystem.shared.spacer.md),
            
            //StackView
            stackView.topAnchor.constraint(equalTo: card.topAnchor, constant: DesignSystem.shared.spacer.md),
            stackView.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: DesignSystem.shared.spacer.md),
            stackView.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -DesignSystem.shared.spacer.md),
            stackView.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -DesignSystem.shared.spacer.md)
        ])
    }
}
