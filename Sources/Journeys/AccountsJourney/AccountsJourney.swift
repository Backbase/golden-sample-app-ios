//
//  AccountsJourney.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 12/10/2023.
//

import UIKit

struct AccountsJourney {
    
    static func build() -> UIViewController {
        let viewModel = AccountsJourneyViewModel()
        let viewController = AccountsViewController()
        
        viewController.bind(viewModel: viewModel)
        return viewController
        
    }
}