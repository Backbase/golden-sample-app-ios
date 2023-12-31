//
//  AccountUIMapper+SavingsAccounts.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 17/11/2023.
//

import Foundation
import Resolver

extension AccountsJourney.SavingsAccounts {
    func mapToUi() -> AccountsUIModel? {
        if !products.isEmpty {
            let config: AccountsJourney.Configuration = Resolver.resolve()
            return AccountsUIModel(
                header: config.accountsList.strings.savingsAccountTitle(),
                products: products.map {
                    return AccountUIModel(
                        id: $0.identifier,
                        name: $0.name,
                        balance: Currency(
                            amount: $0.bookedBalance,
                            currencyCode: $0.currency
                        ),
                        state: formatState($0.state, number: $0.bban ?? $0.iban ?? $0.bic),
                        isVisible: $0.visible,
                        iconName: config.design.accountIcon(.savings)
                    )
                })
        } else {
            return nil
        }
    }
}
