//
//  AppDelegate+Observability.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 07/02/2024.
//

import Resolver
import BackbaseObservability

extension AppDelegate {
    func setupObservability() {
        let tracker = TrackerBuilder.create()
        Resolver.register { tracker }
    }
}
