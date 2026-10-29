//
//  AccountDetailsDataMapper.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 29/11/2023.
//

import Foundation
import ArrangementsClient2Gen2

extension AccountArrangementItem {
    func toMapUI(configuration: AccountsJourney.Configuration) -> AccountDetailsData {
        return AccountDetailsData(
            id: id,
            name: name ?? "",
            displayName: displayName ?? "",
            BBAN: BBAN ?? BIC ?? "",
            currency: currency,
            availableBalance: availableBalance ?? .init(),
            accountHolderNames: accountHolderNames ?? "",
            productKindName: productKindName ?? "",
            productTypeName: productTypeName ?? "",
            bankBranchCode: bankBranchCode,
            lastUpdateDate: lastUpdateDate?.description ?? "",
            accountInterestRate: accountInterestRate?.description,
            accruedInterest: accruedInterest ?? .init(),
            creditLimit: creditLimit ?? .init(),
            accountOpeningDate: accountOpeningDate?.description ?? "",
            accountState: state?.state,
            iconName: configuration.design.accountIcon(.init(rawValue: product?.externalId ?? "") ?? .general)
        )
    }
}
