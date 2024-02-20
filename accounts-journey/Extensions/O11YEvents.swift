//
//  O11YEvents.swift
//  AccountsJourney
//
//  Created by George Nyakundi on 07/02/2024.
//

import Foundation
import BackbaseObservability

extension ScreenViewEvent {
    enum ScreenName: String {
        case accountsList = "accounts_list"
        case accountDetails = "account_details"
    }
    
    init(_ screenName: ScreenName, addition: String? = nil) {
        self.init(name: screenName.rawValue, journey: "accounts_transactions", addition: addition)
    }
}

extension UserActionEvent {
    
    enum EventName: String {
        case refreshAccounts = "refresh_accounts"
    }
    
    convenience init(_ eventName: EventName, attributes: [String: BackbaseObservability.BasicEventData] = [:]) {
        self.init(name: eventName.rawValue, journey: "accounts_transactions", attributes: attributes)
    }
}
