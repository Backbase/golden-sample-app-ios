//
//  AccountsJourneyDesign.swift
//  AccountsJourney
//
//  Created by George Nyakundi on 06/11/2023.
//

import UIKit
import BackbaseDesignSystem

extension AccountsJourney {
    public struct Design {
        
        /// Configuration of styles using in Accounts screen
        var styles = Styles()
        
        /// Accounts list shimmer view image
        var shimmerImage = UIImage.named("AccountsLoading", in: .accountsJourney)
        
        /// An "X" image (badge) shown on top of the Account icon.
        var closedAccountIconBadge = UIImage.named(DesignSystem.Assets.icClose, in: .design)
        
        var accountIcon: (AccountsJourney.AccountType) -> AccountIconInfo? = { accountType in
            switch accountType {
            case .creditCard:
                return AccountIconInfo(
                    icon: UIImage.named("Card", in: .accountsJourney),
                    backgroundColor: UIColor(
                        light: DesignSystem.shared.colors.accent.lightest.light,
                        dark: darkIconBackgroundColor)
                )
            case .current:
                return AccountIconInfo(
                    icon: UIImage.named("Current", in: .accountsJourney),
                    backgroundColor: UIColor(
                        light: DesignSystem.shared.colors.primary.lightest,
                        dark: darkIconBackgroundColor)
                )
            case .debitCard:
                return AccountIconInfo(
                    icon: UIImage.named("DebitCard", in: .accountsJourney),
                    backgroundColor: UIColor(
                        light: DesignSystem.shared.colors.accent.lightest.light,
                        dark: darkIconBackgroundColor)
                )
            case .investment:
                return AccountIconInfo(
                    icon: UIImage.named("Investment", in: .accountsJourney),
                    backgroundColor: UIColor(
                        light: DesignSystem.shared.colors.charts.five.lightest.light,
                        dark: darkIconBackgroundColor)
                )
            case .loan:
                return AccountIconInfo(
                    icon: UIImage.named("Loan", in: .accountsJourney),
                    backgroundColor: UIColor(
                        light: DesignSystem.shared.colors.charts.two.lightest.light,
                        dark: darkIconBackgroundColor)
                )
            case .savings:
                return AccountIconInfo(
                    icon: UIImage.named("Savings", in: .accountsJourney),
                    backgroundColor: UIColor(
                        light: DesignSystem.shared.colors.success.lightest,
                        dark: darkIconBackgroundColor)
                )
            case .termDeposit:
                return AccountIconInfo(
                    icon: UIImage.named("TermDeposits", in: .accountsJourney),
                    backgroundColor: UIColor(
                        light: DesignSystem.shared.colors.success.lightest,
                        dark: darkIconBackgroundColor)
                )
            case .general:
                return AccountIconInfo(
                    icon: UIImage.named("General", in: .accountsJourney),
                    backgroundColor: UIColor(
                        light: DesignSystem.shared.colors.primary.lightest,
                        dark: darkIconBackgroundColor)
                )
            }
        }
        
        static let darkIconBackgroundColor: UIColor = DesignSystem.shared.colors.surfaceSecondary.default
    }
}
