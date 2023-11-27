//
//  AccountsJourneyRouter.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 07/11/2023.
//

import UIKit

extension AccountsJourney {
    
    /// Accounts Journey router
    struct Router {
        var didSelectProduct: (UINavigationController) -> () -> Void
    }
}
