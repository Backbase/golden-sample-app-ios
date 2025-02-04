//
//  SplashRouter.swift
//  AppCommon
//
//  Created by George Nyakundi on 04/02/2025.
//

import UIKit

public extension Splash {
    /// Splash router.
    struct Router {
        /// Called when the Splash screen's waiting is finished.
        public var didFinishWaiting: (() -> Void)?
    }
}

