//
//  AccountsListError+StateViewConfiguration.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 13/11/2023.
//

import BackbaseDesignSystem
import Foundation

extension AccountsList.Error {

    /// What `StateConfigurationView` shows for this error. `primaryAction` is only used
    /// when the error has an action button, i.e. when it can be retried.
    func stateViewConfiguration(
        using journeyConfiguration: AccountsJourney.Configuration,
        primaryAction: @escaping () -> Void
    ) -> StateViewConfiguration {
        let accountsList = journeyConfiguration.accountsList
        let retryTitle = accountsList.strings.errorRetryButtonTitle(self)?()
        return GenericStateViewConfiguration(
            iconName: accountsList.design.errorIconName(self),
            title: accountsList.strings.errorTitle(self)(),
            subtitle: accountsList.strings.errorSubtitle(self)(),
            animationView: nil,
            firstButtonConfiguration: retryTitle.map { ButtonConfiguration(title: $0, action: primaryAction) },
            secondButtonConfiguration: nil,
            thirdButtonConfiguration: nil
        )
    }
}
