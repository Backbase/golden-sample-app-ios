//
//  AccountsJourney.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 12/10/2023.
//

import UIKit

public struct AccountsJourney {
    
    public static func build() -> UIViewController {
        let viewModel = AccountsListViewModel()
        let viewController = AccountsListViewController()
        viewController.bind(viewModel: viewModel)
        return viewController
        
    }
}
