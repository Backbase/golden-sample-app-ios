//
//  AccountsListDesign.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 27/11/2023.
//

import UIKit
import BackbaseDesignSystem

extension AccountsList {
    public struct Design {
        /// Configuration of styles used in AccountList screen
        var styles = Styles()
        
        /// Icon name base of the ErrorType
        public var errorIconName: ErrorFormatter<String> = { error in
            switch error {
            case .noAccounts:
                DesignSystem.Assets.icStateViewNoWifi
            default:
                DesignSystem.Assets.icStateViewLoadingFailed
            }
        }
    }
}
