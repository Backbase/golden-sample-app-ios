//
//  AccountsListViewModel+StateViewConfiguration.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 13/11/2023.
//

import Foundation
import BackbaseDesignSystem

// MARK: StateViewConfiguration
extension AccountsListViewModel {
    func stateViewConfiguration(
        for error: AccountsList.Error,
        primaryAction: @escaping () -> Void
    ) -> StateViewConfiguration {
        var primaryButtonConfiguration: ButtonConfiguration?
        if let primaryButtonText = error.actionButtonTitle {
            primaryButtonConfiguration = .init(
                title: primaryButtonText,
                action: primaryAction)
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
