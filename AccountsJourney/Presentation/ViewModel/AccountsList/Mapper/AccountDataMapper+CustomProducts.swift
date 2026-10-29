//
//  AccountDataMapper+CustomProducts.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 17/11/2023.
//

import Foundation
import ArrangementsClient2Gen2

extension CustomProductKind {
    func mapToUi(configuration config: AccountsJourney.Configuration) -> AccountsData {
        
        var accountsData = AccountsData()
        if !products.isEmpty {
            accountsData = AccountsData(
                header: config.accountsList.strings.generalAccountTitle(),
                products: products.map {
                    AccountData(
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
        return accountsData
    }
}
