//
//  AccountsListConfiguration.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 11/10/2023.
//

import Foundation
import BackbaseDesignSystem
import Resolver

extension AccountsList {
    public struct Configuration {
        /// Create a new Configuration object with default values
        public init() {
            // no code required
        }
        
        /// Configuration of styles used in Accounts List
        public var design = Design()
        
        /// Configuration of strings used in Accounts List
        public var strings = Strings()
        
        /// AccountsListRowItem configuration
        public var accountListRowProvider: (AccountUIModel) -> AccountsListRowItem = { item in
            let configuration = Resolver.resolve(AccountsJourney.Configuration.self)
            
            var accountName: AccountsListRowItem.StyleableText? = .text(item.name ?? "", configuration.design.styles.accountName)
            
            var stateText: String?
            if configuration.accountsList.isAccountClosed(item) {
                stateText = configuration.accountsList.strings.closedAccountSubtitle()
            } else if configuration.accountsList.isAccountInactive(item) {
                stateText = configuration.accountsList.strings.inactiveAccountSubtitle()
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
