//
//  AccountDetailUIMapper.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 29/11/2023.
//

import Foundation
import Resolver

extension AccountsJourney.AccountDetailsModel {
    func toMapUI() -> AccountDetailsUIModel {
        let config: AccountsJourney.Configuration = Resolver.resolve()
        return AccountDetailsUIModel(
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
            accountInterestRate: accountInterestRate?.description ?? "",
            accruedInterest: accruedInterest ?? .init(),
            creditLimit: creditLimit ?? .init(),
            accountOpeningDate: accountOpeningDate?.description ?? "", accountState: state?.state,
            iconName: config.design.accountIcon(.init(rawValue: product?.externalId ?? "") ?? .general
        )
        )
    }
}
