//
//  AccountsListDesign.swift
//  AccountsJourney
//
//  Created by George Nyakundi on 27/11/2023.
//

import UIKit
import Resolver
import BackbaseDesignSystem

extension AccountsList {
    public struct Design {
        /// Configuration of styles used in AccountList screen
        var styles = Styles()
        
        public var errorIconName: ErrorFormatter<String?> = { error in
            switch error {
            case .noAccounts:
                DesignSystem.Assets.icStateViewNoWifi
            default:
                DesignSystem.Assets.icStateViewLoadingFailed
            }
        }
    }
}
