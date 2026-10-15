//
//  AccountDataMapper+SavingsAccounts.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 17/11/2023.
//

import Foundation
import ArrangementsClient2Gen2

extension SavingsAccountProductKinds {
    func mapToUi(configuration config: AccountsJourney.Configuration) -> AccountsData? {
        if !products.isEmpty {
            return AccountsData(
                header: config.accountsList.strings.savingsAccountTitle(),
                products: products.map {
                    return AccountData(
                        id: $0.id,
                        name: $0.name,
                        balance: Currency(
                            amount: $0.bookedBalance,
                            currencyCode: $0.currency
                        ),
                        state: formatState($0.state, number: $0.BBAN ?? $0.IBAN ?? $0.BIC),
                        isVisible: $0.visible,
                        iconName: config.design.accountIcon(.savings)
                    )
                })
        } else {
            return nil
        }
    }
}
