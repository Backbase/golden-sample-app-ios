//
//  Created by Backbase on 16/02/2024.
//

import UIKit
import BackbaseDesignSystem
import Resolver
import Combine

final class AccountListSearchBarView: UIView {
    private let configuration: AccountsJourney.Configuration = Resolver.resolve()
    private let searchBar = UISearchBar(frame: .zero)
    var cancellable: AnyCancellable?
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
        backgroundColor = .clear

        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom
                .equalToSuperview()
                .inset(DesignSystem.shared.spacer.md)
            make.leading.trailing
                .equalToSuperview()
                .inset(-DesignSystem.shared.spacer.sm)
        }
    }

    private func setupConfiguration() {
        searchBar.placeholder = configuration.accountsList.strings.searchText()
        configuration.accountsList.design.styles.searchBar(searchBar)
    }
}

extension AccountListSearchBarView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        textChangeSubject.send(searchText)
    }
}
