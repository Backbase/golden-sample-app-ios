//
// Copyright © 2025 Backbase R&D B.V. All rights reserved.
//

import SwiftUI

@MainActor
open class IntentHandler<State: Observable, Intent> {
    public let state: State
    
    public init(_ state: State) {
        self.state = state
    }
    
    public func sendIntent(_ intent: Intent) {
        Task {
            await handleIntent(intent)
        }
    }
    
    open func handleIntent(_ intent: Intent) async {
        fatalError("handleIntent must be implemented in subclasses")
    }
}
