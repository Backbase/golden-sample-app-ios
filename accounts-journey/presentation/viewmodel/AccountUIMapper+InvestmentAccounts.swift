//
//  AccountUIMapper+InvestmentAccounts.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 17/11/2023.
//

import Foundation
import Resolver

extension AccountsJourney.InvestmentAccounts {
    func mapToUi() -> AccountsUIModel? {
        if !products.isEmpty {
            let config: AccountsJourney.Configuration = Resolver.resolve()
            return AccountsUIModel(
                header: config.strings.investmentAccountTitle(),
                products: products.map {
                    return AccountUIModel(
                        id: $0.identifier,
                        name: $0.name,
                        balance: Currency(
                            amount: String($0.reservedAmount ?? 0),
                            currencyCode: nil
                        ),
                        state: formatState($0.state, number: $0.iban ?? $0.bban),
                        isVisible: $0.visible,
                        iconName: config.design.accountIcon(.investment)
                    )
                })
        } else {
            return nil
        }
    }
}
