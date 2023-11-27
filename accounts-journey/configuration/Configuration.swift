//
//  AccountsJourneyConfiguration.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 11/10/2023.
//

import Foundation
import Resolver
import BackbaseDesignSystem

extension AccountsJourney {
    public struct Configuration {
        /// Create a new Configuration object with default values
        public init() {
            // no code required
        }
        // Configuration for ``AccountsList`` screen
        public var accountsList = AccountsList.Configuration()
        
        /// Configuration of styles used in the Accounts Screen
        public var design = Design()
        
        public var strings = Strings()
        
        public var accountRowProvider: (AccountUIModel) -> AccountsListRowItem = { item in
            let configuration = Resolver.resolve(AccountsJourney.Configuration.self)
            
            var accountName: AccountsListRowItem.StyleableText? = .text(item.name ?? "", configuration.design.styles.accountName)
            
            var stateText: String?
            if configuration.isAccountClosed(item) {
                stateText = configuration.strings.closedAccountSubtitle()
            } else if configuration.isAccountInactive(item) {
                stateText = configuration.strings.inactiveAccountSubtitle()
            } else {
                stateText = item.state
            }
            let accountState: AccountsListRowItem.StyleableText?
            if let stateText {
                accountState = .text(stateText, configuration.design.styles.accountState)
            } else {
                accountState = nil
            }
            
            let amountBalance: AccountsListRowItem.StyleableText?
            if let balance = item.balance {
                let currencyStyleSelector: StyleSelector<(String, String), UILabel> = { values in
                    return { label in
                        configuration.design.styles.currencyFormatter(values)(label)
                        configuration.design.styles.accountBalance(label)
                    }
                    
                }
                amountBalance = .currency(balance, currencyStyleSelector)
            } else {
                amountBalance = .text("", nil)
            }
            let accountIcon = item.iconName
            return AccountsListRowItem(
                id: item.id,
                accountIcon: accountIcon,
                accountName: accountName,
                stateLabel: accountState,
                accountBalance: amountBalance
            )
            
        }
        
        var isAccountInactive: (AccountUIModel) -> Bool = { account in
            account.state?.lowercased() == "inactive"
        }
        
        var isAccountClosed: (AccountUIModel) -> Bool = { account in
            account.state?.lowercased() == "closed"
        }
        
    }
}
