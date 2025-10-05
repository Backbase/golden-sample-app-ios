//
//  AccountUIMapper+CustomProducts.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 17/11/2023.
//

import Foundation
import Resolver
import ArrangementsClient2Gen2

extension CustomProductKind {
    func mapToUi() -> AccountsUIModel {
        
        var accountsUIModel = AccountsUIModel()
        if !products.isEmpty {
            let config: AccountsJourney.Configuration = Resolver.resolve()
            accountsUIModel = AccountsUIModel(
                header: config.accountsList.strings.generalAccountTitle(),
                products: products.map {
                    AccountUIModel(
                        id: $0.id,
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
