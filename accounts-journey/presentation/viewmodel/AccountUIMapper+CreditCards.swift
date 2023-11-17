//
//  AccountUIMapper+CreditCards.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 17/11/2023.
//

import Foundation
import Resolver

extension AccountsJourney.CreditCards {
    func mapToUi() -> AccountsUIModel? {
        if !products.isEmpty {
            let config: AccountsJourney.Configuration = Resolver.resolve()
            return AccountsUIModel(
                header: config.strings.creditCardTitle(),
                products: products.map {
                    return AccountUIModel(
                        id: $0.identifier,
                        name: $0.name,
                        balance: Currency(
                            amount: $0.bookedBalance,
                            currencyCode: $0.currency
                        ),
                        state: formatState($0.state, number: $0.number),
                        isVisible: $0.visible,
                        iconName: config.design.accountIcon(.creditCard)
                    )
                })
        } else {
            return nil
        }
    }
}
