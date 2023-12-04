//
//  AppDelegate+AccountsJourney.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 13/10/2023.
//

import Foundation
import Backbase
import Resolver
import AccountsJourney

extension AppDelegate {
    func setupAccountsJourney() {
        Resolver.register { AccountsJourney.Configuration() }
    }
}
