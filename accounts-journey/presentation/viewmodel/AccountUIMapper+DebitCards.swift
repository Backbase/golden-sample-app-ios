//
//  AccountUIMapper+DebitCards.swift
//  AccountsJourney
//
//  Created by George Nyakundi on 17/11/2023.
//

import Foundation
import Resolver


extension AccountsJourney.DebitCards {
    func mapToUi() -> AccountsUIModel? {
        if !self.products.isEmpty {
            let config: AccountsJourney.Configuration = Resolver.resolve()
            return AccountsUIModel(
                header: config.strings.debitCardTitle(),
                products: self.products.map {
                    return AccountUIModel(
                        id: $0.identifier,
                        name: $0.name,
                        balance: Currency(
                            amount: String($0.reservedAmount ?? 0),
                            currencyCode: nil
                        ),
                        state: formatState($0.state, number: $0.number),
                        isVisible: $0.visible,
                        iconName: config.design.accountIcon(.debitCard)
                    )
                })
        } else {
            return nil
        }
    }
}
