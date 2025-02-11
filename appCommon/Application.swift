//
//  Application.swift
//  GoldenSampleApp
//
//  Created by Backbase on 04/02/2025.
//

import UIKit
import Foundation
import Resolver

/**
 * A custom `UIApplication` subclass that intercepts and handles UI events.
 *
 * This class overrides the `sendEvent(_:)` method to intercept all UI events
 * dispatched to the application. It then forwards these events to the
 * `UserInactivityTracker` associated with the `AppRouter` (if available)
 * to monitor for user inactivity.  This allows the application to track
 * user interaction at a global level.
 */
public class Application: UIApplication {
    
    ///
    ///  Sends an event to the appropriate responder objects in the application.
    ///
    ///  This override intercepts the event and forwards it to the superclass's
    ///  implementation for normal event handling.  Additionally, it retrieves
    ///  the `AppRouter` from the dependency resolver (if it exists) and calls
    ///  the `handleSendEvent(_:)` method on its `userInactivityTracker` to
    ///  update the inactivity timer.
    ///
    ///  - Parameter event: The UIEvent object to be sent.
    ///
    public override func sendEvent(_ event: UIEvent) {
        super.sendEvent(event)
        Resolver.optional(AppRouter.self)?.userInactivityTracker.handleSendEvent(event)
    }
}
