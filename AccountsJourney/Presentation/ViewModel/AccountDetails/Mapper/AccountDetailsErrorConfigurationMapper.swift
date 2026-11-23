//
//  AccountDetailsErrorConfigurationMapper.swift
//  AccountsJourney
//

import BackbaseDesignSystem
import Foundation

/// Turns an `AccountDetails.Error` into the `StateViewConfiguration` the error state of the screen shows.
///
/// Stateless: owned by the view model, which decides when to map and what the retry button runs.
struct AccountDetailsErrorConfigurationMapper {

    private let strings: AccountDetails.Strings
    private let design: AccountDetails.Design

    /// - Parameters:
    ///   - strings: The localised texts of the screen.
    ///   - design: Provides the icon of each error.
    init(strings: AccountDetails.Strings, design: AccountDetails.Design) {
        self.strings = strings
        self.design = design
    }

    /// Takes the strings and the design of the journey configuration.
    init(journeyConfiguration: AccountsJourney.Configuration) {
        self.init(strings: journeyConfiguration.accountDetails.strings, design: journeyConfiguration.accountDetails.design)
    }

    /// - Parameters:
    ///   - error: The error to show.
    ///   - retry: What the button runs. Only used when the error has a button, i.e. when it can be retried.
    func stateViewConfiguration(for error: AccountDetails.Error, retry: @escaping () -> Void) -> StateViewConfiguration {
        let retryTitle = strings.errorRetryButtonTitle(error)?()
        return GenericStateViewConfiguration(
            iconName: design.errorIconName(error),
            title: strings.errorTitle(error)(),
            subtitle: strings.errorSubtitle(error)(),
            animationView: nil,
            firstButtonConfiguration: retryTitle.map { ButtonConfiguration(title: $0, action: retry) },
            secondButtonConfiguration: nil,
            thirdButtonConfiguration: nil
        )
    }
}
