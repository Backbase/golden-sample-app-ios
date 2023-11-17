//
//  AccountUIMapper+CustomProducts.swift
//  AccountsJourney
//
//  Created by George Nyakundi on 17/11/2023.
//

import Foundation
import Resolver

extension AccountsJourney.CustomProducts {
    func mapToUi() -> AccountsUIModel {
        
        var accountsUIModel = AccountsUIModel()
        if !products.isEmpty {
            let config: AccountsJourney.Configuration = Resolver.resolve()
            accountsUIModel = AccountsUIModel(
                header: config.strings.generalAccountTitle(),
                products: products.map {
                    AccountUIModel(
                        id: $0.identifier,
                        name: $0.name,
                        balance: Currency(
                            amount: $0.bookedBalance,
                            currencyCode: $0.currency
                        ),
                        state: formatState($0.state, number: $0.productKindName),
                        isVisible: $0.visible,
                        iconName: config.design.accountIcon(.general)
                    )
                })
        }
        return accountsUIModel
    }
}
