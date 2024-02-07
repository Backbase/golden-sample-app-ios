//
//  Tracker.swift
//  AccountsJourney
//
//  Created by George Nyakundi on 07/02/2024.
//

import Foundation
import BackbaseObservability

extension AccountsJourney {
    /// Namespace for UserEvents and ScreenEvents tracker within the journey
    enum Tracker {
        /// Journey name
        static let journeyName = "accounts_journey"
        
        /// ScreenEvent
        enum ScreenEvent: String {
            case accounts
            case account_details
        }
        
        /// UserAction
        enum UserAction: String {
            case refresh_accounts
            case search_accounts
        }
        
        /// Helper method that returns a `ScreenViewEvent`
        /// - Parameter screen: ScreenEvent of type `Tracker.ScreenEvent`
        /// - Returns: a `ScreenViewEvent`
        static func event(forScreen screen: ScreenEvent) -> ScreenViewEvent {
            ScreenViewEvent(name: screen.rawValue, journey: Tracker.journeyName)
        }
        
        /// Helper method that returns a `UserActionEvent`
        /// - Parameter action: UserAction of type `Tracker.UserAction`
        /// - Returns: a `UserActionEvent`
        static func event(forUserAction action: UserAction) -> UserActionEvent {
            UserActionEvent(name: action.rawValue, journey: Tracker.journeyName)
        }
    }
}
