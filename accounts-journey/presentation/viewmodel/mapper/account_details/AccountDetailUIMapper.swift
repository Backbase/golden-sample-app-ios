//
//  AccountDetailUIMapper.swift
//  AccountsJourney
//
//  Created by George Nyakundi on 29/11/2023.
//

import Foundation
import Resolver

extension AccountsJourney.AccountDetailsModel {
    func toMapUI() -> AccountDetailsUIModel {
        let config: AccountsJourney.Configuration = Resolver.resolve()
        
        return AccountDetailsUIModel(
            id: id,
            name: name!,
            BBAN: BBAN!,
            availableBalance: availableBalance ?? .init(),
            accountHolderNames: accountHolderNames!,
            productKindName: productKindName!,
            bankBranchCode: bankBranchCode,
            lastUpdateDate: lastUpdateDate?.description ?? "",
            accountInterestRate: accountInterestRate?.description ?? "",
            accruedInterest: accruedInterest ?? .init(),
            creditLimit: creditLimit ?? .init(),
            accountOpeningDate: accountOpeningDate?.description ?? "",
            iconName: config.design.accountIcon(.init(rawValue: product?.externalId ?? "") ?? .general)
        )
    }
}
