//
//  AccountDetailsDesign.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 29/11/2023.
//

import Foundation
import BackbaseDesignSystem

extension AccountDetails {
    public struct Design {
        /// AccountDetail screen styles
        var styles = Styles()
        /// Error icon name for possible errors
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
