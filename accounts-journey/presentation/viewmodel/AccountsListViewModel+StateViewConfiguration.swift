//
//  AccountsListViewModel+StateViewConfiguration.swift
//  AccountsJourney
//
//  Created by George Nyakundi on 13/11/2023.
//

import Foundation
import BackbaseDesignSystem


// MARK: StateViewConfiguration
extension AccountsListViewModel {
    func stateViewConfiguration(for error: AccountsJourney.Error) -> StateViewConfiguration {
        var primaryButtonConfiguration: ButtonConfiguration?
        if let primaryButtonText = error.actionButtonTitle {
            primaryButtonConfiguration = .init(
                title: primaryButtonText,
                action: {[weak self] in
                    self?.getAccountSummary(fromEvent: .refresh)
                })
        }
        
        return GenericStateViewConfiguration(
            iconName: error.icon,
            title: error.title,
            subtitle: error.subtitle,
            animationView: nil,
            firstButtonConfiguration: primaryButtonConfiguration,
            secondButtonConfiguration: nil
        )
    }
}
