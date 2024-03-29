//
//  AppDelegate+Observability.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 07/02/2024.
//

import Resolver
import BackbaseObservability
import BackbaseOpenTelemetryConnector

extension AppDelegate {
    func setupObservability() {
        let tracker = TrackerBuilder.create()
        tracker.enableBackbaseOpenTelemetryConnector(appKey: "975db35b-2a6b-42d5-899f-01f40f931955")
        Resolver.register { tracker }
    }
}
