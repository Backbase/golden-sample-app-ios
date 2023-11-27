//
//  AccountsList.swift
//  AccountsJourney
//
//  Created by George Nyakundi on 27/11/2023.
//

import UIKit

public struct AccountsList {
    /// Main entry point to the AccountsList
    /// - Returns: a UIViewController 
    public static func build() -> UIViewController {
        let viewModel = AccountsListViewModel()
        let viewController = AccountsListViewController(viewModel: viewModel)
        return viewController
    }
}
