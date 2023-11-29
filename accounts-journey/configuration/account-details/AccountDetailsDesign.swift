//
//  AccountDetailsDesign.swift
//  AccountsJourney
//
//  Created by George Nyakundi on 29/11/2023.
//

import Foundation
import BackbaseDesignSystem

extension AccountDetails {
    public struct Design {
        var styles = Styles()
        
        public var errorIconName: ErrorFormatter<String?> = { error in
            switch error {
            case .notConnected:
                DesignSystem.Assets.icStateViewNoWifi
            default:
                DesignSystem.Assets.icStateViewLoadingFailed
            }
        }
    }
}
