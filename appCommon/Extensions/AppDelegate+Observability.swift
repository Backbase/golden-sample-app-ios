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

        tracker.subscribe(
            subscriber: self,
            eventClass: ScreenViewEvent.self) { event in
                debugPrint("Screen View Event Name => \(event.name)")
                debugPrint("Screen View Event Journey Name => \(event.journey)")
            }

        tracker.subscribe(subscriber: self,
                          eventClass: UserActionEvent.self) { event in
            debugPrint("User Action Event Name => \(event.name)")
            debugPrint("User Action Event Journey Name => \(event.journey)")
            debugPrint("User Action Event Attributes => \(event.attributes)")
        }
    }
}
