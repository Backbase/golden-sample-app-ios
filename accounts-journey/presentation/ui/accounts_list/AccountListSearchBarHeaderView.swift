//
//  Created by Backbase on 16/02/2024.
//

import UIKit
import BackbaseDesignSystem
import Resolver
import Combine

final class AccountListSearchBarHeaderView: UIView {
    private let configuration: AccountsJourney.Configuration = Resolver.resolve()
    private let searchBar: UISearchBar = {
       let view = UISearchBar(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let textChangeSubject = PassthroughSubject<String, Never>()

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        setupSubviews()
        setupConfiguration()
        searchBar.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.topAnchor),
            searchBar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -DesignSystem.shared.spacer.md),
            searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: DesignSystem.shared.spacer.sm),
            searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -DesignSystem.shared.spacer.sm)
        ])
    }

    private func setupConfiguration() {
        backgroundColor = .clear
        searchBar.placeholder = configuration.accountsList.strings.searchText()
        configuration.accountsList.design.styles.searchBar(searchBar)
    }
}

extension AccountListSearchBarHeaderView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        textChangeSubject.send(searchText)
    }
}
