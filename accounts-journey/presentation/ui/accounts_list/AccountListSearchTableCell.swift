//
//  Created by Backbase on 16/02/2024.
//

import UIKit
import BackbaseDesignSystem
import Resolver

final class AccountListSearchTableCell: UITableViewCell, Reusable, CellCornerModifier {
    private let configuration: AccountsJourney.Configuration = Resolver.resolve()
    let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 0, height: 60))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        contentView.addSubview(searchBar)
        contentView.backgroundColor = .clear
        backgroundColor = DesignSystem.shared.colors.surfacePrimary.default

        searchBar.snp.makeConstraints { make in
            make.edges
                .equalToSuperview()
                .inset(DesignSystem.shared.spacer.sm)
        }
    }

    private func setupConfiguration() {
        searchBar.placeholder = configuration.accountsList.strings.searchText()
        configuration.accountsList.design.styles.searchBar(searchBar)
    }
}

extension AccountListSearchTableCell: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // TODO here
//        viewModel.onEvent(.search(""))
    }
}
