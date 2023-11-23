//
//  AccountUIMapper+Loans.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 17/11/2023.
//

import Foundation
import Resolver

extension AccountsJourney.Loans {
    func mapToUi() -> AccountsUIModel? {
        if !products.isEmpty {
            let config: AccountsJourney.Configuration = Resolver.resolve()
            return AccountsUIModel(
                header: config.strings.loanAccountTitle(),
                products: products.map {
                    return AccountUIModel(
                        id: $0.identifier,
                        name: $0.name,
                        balance: Currency(
                            amount: $0.bookedBalance,
                            currencyCode: $0.currency
                        ),
                        state: formatState($0.state, number: $0.bban ?? $0.iban),
                        isVisible: $0.visible,
                        iconName: config.design.accountIcon(.loan)
                    )
                })
        } else {
            return nil
        }
    }
}
