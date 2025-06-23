//
//  AccountUIMapper+DebitCards.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 17/11/2023.
//

import Foundation
import Resolver
import ArrangementsClient2Gen2

extension DebitCardProductKinds {
    func mapToUi() -> AccountsUIModel? {
        if !products.isEmpty {
            let config: AccountsJourney.Configuration = Resolver.resolve()
            return AccountsUIModel(
                header: config.accountsList.strings.debitCardTitle(),
                products: products.map {
                    return AccountUIModel(
                        id: $0.id,
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
