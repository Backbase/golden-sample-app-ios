//
//  AccountListRouter.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 29/11/2023.
//

import UIKit

extension AccountsList {
    /// Accounts List router
    public struct Router {
        public var didSelectProduct: (UINavigationController) -> (String) -> Void
    }
}
