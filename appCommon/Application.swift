//
//  Application.swift
//  GoldenSampleApp
//
//  Created by Backbase on 04/02/2025.
//

import UIKit
import Foundation
import Resolver

public class Application: UIApplication {
    public override func sendEvent(_ event: UIEvent) {
        super.sendEvent(event)
        Resolver.optional(AppRouter.self)?.userInactivityTracker.handleSendEvent(event)
    }
}
