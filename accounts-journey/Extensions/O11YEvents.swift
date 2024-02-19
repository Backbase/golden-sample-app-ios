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
        case accounts_list = "accounts-list"
        case account_details = "account-details"
    }
    
    init(_ screenName: ScreenName, addition: String? = nil) {
        self.init(name: screenName.rawValue, journey: "accounts-transactions", addition: addition)
    }
}

extension UserActionEvent {
    
    enum EventName: String {
        case refresh_accounts = "refresh-accounts"
        case search_accounts = "search-accounts"
    }
    convenience init(_ eventName: EventName, attributes: [String : BackbaseObservability.BasicEventData] = [:]) {
        self.init(name: eventName.rawValue, journey: "accounts-transactions", attributes: attributes)
    }
}
