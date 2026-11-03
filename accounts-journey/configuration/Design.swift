//
//  AccountsJourneyDesign.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 06/11/2023.
//

import UIKit
import BackbaseDesignSystem

extension AccountsJourney {
    public struct Design {
        
        var styles = Styles()
        
        /// Account icon based of account / product type
        public var accountIcon: (AccountsJourney.AccountType) -> AccountIconInfo? = { accountType in
            switch accountType {
            case .creditCard:
                return AccountIconInfo(
                    icon: UIImage.named("Card", in: .accountsJourney),
                    backgroundColor: UIColor(
                        light: Theme.colors.background.brandSubtle,
                        dark: darkIconBackgroundColor)
                )
            case .current:
                return AccountIconInfo(
                    icon: UIImage.named("Current", in: .accountsJourney),
                    backgroundColor: UIColor(
                        light: Theme.colors.background.brandSubtle,
                        dark: darkIconBackgroundColor)
                )
            case .debitCard:
                return AccountIconInfo(
                    icon: UIImage.named("DebitCard", in: .accountsJourney),
                    backgroundColor: UIColor(
                        light: Theme.colors.background.brandSubtle,
                        dark: darkIconBackgroundColor)
                )
            case .investment:
                return AccountIconInfo(
                    icon: UIImage.named("Investment", in: .accountsJourney),
                    backgroundColor: UIColor(
                        light: Theme.colors.background.category5Subtle,
                        dark: darkIconBackgroundColor)
                )
            case .loan:
                return AccountIconInfo(
                    icon: UIImage.named("Loan", in: .accountsJourney),
                    backgroundColor: UIColor(
                        light: Theme.colors.background.category2Subtle,
                        dark: darkIconBackgroundColor)
                )
            case .savings:
                return AccountIconInfo(
                    icon: UIImage.named("Savings", in: .accountsJourney),
                    backgroundColor: UIColor(
                        light: Theme.colors.background.successSubtle,
                        dark: darkIconBackgroundColor)
                )
            case .termDeposit:
                return AccountIconInfo(
                    icon: UIImage.named("TermDeposits", in: .accountsJourney),
                    backgroundColor: UIColor(
                        light: Theme.colors.background.successSubtle,
                        dark: darkIconBackgroundColor)
                )
            case .general:
                return AccountIconInfo(
                    icon: UIImage.named("General", in: .accountsJourney),
                    backgroundColor: UIColor(
                        light: Theme.colors.background.brandSubtle,
                        dark: darkIconBackgroundColor)
                )
            }
        }
        
        /// a dark icon background color
        public static let darkIconBackgroundColor: UIColor = Theme.colors.background.surface2
    }
}
