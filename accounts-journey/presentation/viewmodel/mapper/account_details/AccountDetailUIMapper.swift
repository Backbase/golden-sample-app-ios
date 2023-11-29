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
            availableBalance: availableBalance?.description ?? "",
            accountHolderNames: accountHolderNames!,
            productKindName: productKindName!,
            bankBranchCode: bankBranchCode,
            lastUpdateDate: lastUpdateDate?.description ?? "",
            accountInterestRate: accountInterestRate?.description ?? "",
            accruedInterest: accruedInterest?.description ?? "",
            creditLimit: creditLimit?.description ?? "",
            accountOpeningDate: accountOpeningDate?.description ?? "",
            iconName: config.design.accountIcon(.creditCard)
        )
    }
}
