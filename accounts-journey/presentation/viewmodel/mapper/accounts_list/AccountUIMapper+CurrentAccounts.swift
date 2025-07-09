//
//  AccountUIMapper+CurrentAccounts.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 17/11/2023.
//

import Foundation
import Resolver
import ArrangementsClient2Gen2

extension CurrentAccountProductKinds {
    func mapToUi() -> AccountsUIModel? {
        if !products.isEmpty {
            let config: AccountsJourney.Configuration = Resolver.resolve()
            return AccountsUIModel(
                header: config.accountsList.strings.currentAccountTitle(),
                products: products.map {
                    return AccountUIModel(
                        id: $0.id,
                        name: $0.name,
                        balance: Currency(
                            amount: $0.bookedBalance,
                            currencyCode: $0.currency
                        ),
                        state: formatState($0.state, number: $0.BBAN ?? $0.IBAN ?? $0.BIC),
                        isVisible: $0.visible,
                        iconName: config.design.accountIcon(.current)
                    )
                })
        } else {
            return nil
        }
    }
}
