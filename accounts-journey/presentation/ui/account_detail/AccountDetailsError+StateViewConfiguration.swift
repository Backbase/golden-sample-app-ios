//
//  AccountDetailsError+StateViewConfiguration.swift
//  AccountsJourney
//

import BackbaseDesignSystem
import Foundation

extension AccountDetails.Error {

    /// What `StateConfigurationView` shows for this error. `primaryAction` is only used
    /// when the error has an action button, i.e. when it can be retried.
    func stateViewConfiguration(
        configuration: AccountsJourney.Configuration,
        primaryAction: @escaping () -> Void
    ) -> StateViewConfiguration {
        let accountDetails = configuration.accountDetails
        let retryTitle = accountDetails.strings.errorRetryButtonTitle(self)?()
        return GenericStateViewConfiguration(
            iconName: accountDetails.design.errorIconName(self),
            title: accountDetails.strings.errorTitle(self)(),
            subtitle: accountDetails.strings.errorSubtitle(self)(),
            animationView: nil,
            firstButtonConfiguration: retryTitle.map { ButtonConfiguration(title: $0, action: primaryAction) },
            secondButtonConfiguration: nil,
            thirdButtonConfiguration: nil
        )
    }
}
