//
//  AccountListRouter.swift
//  AccountsJourney
//
//  Created by George Nyakundi on 29/11/2023.
//

import UIKit

extension AccountsList {
    
    /// Accounts List router
    public struct Router {
        var didSelectProduct: (UINavigationController) -> (String) -> Void
    }
}
