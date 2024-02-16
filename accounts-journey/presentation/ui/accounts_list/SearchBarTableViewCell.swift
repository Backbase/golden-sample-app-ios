//
//  Created by Backbase on 16/02/2024.
//

import UIKit
import BackbaseDesignSystem
import Resolver

class SearchBarTableViewCell: UITableViewCell, Reusable {
    private let configuration: AccountsJourney.Configuration = Resolver.resolve()
    // TODO figure out whether we can move it
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
        backgroundColor = .clear

        searchBar.snp.makeConstraints { make in
            make.top.bottom
                .equalToSuperview()
                .inset(DesignSystem.shared.spacer.md)
            make.leading.trailing.equalToSuperview()
        }
    }

    private func setupConfiguration() {
        searchBar.placeholder = configuration.accountsList.strings.searchText()
        configuration.accountsList.design.styles.searchBar(searchBar)
    }
}

extension SearchBarTableViewCell: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        viewModel.onEvent(.search(""))
    }
}
