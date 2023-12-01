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
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(DesignSystem.shared.spacer.lg)
        }
        card.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(DesignSystem.shared.spacer.xs)
            make.leading.trailing.bottom.equalToSuperview().inset(DesignSystem.shared.spacer.md)
        }
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(DesignSystem.shared.spacer.md)
        }
    }
}
