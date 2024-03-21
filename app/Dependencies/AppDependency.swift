//
//  Created by Backbase R&D B.V. on 13/03/2024
//
    

import Foundation
import Resolver

/// A protocol representing a dependency for the app.
protocol AppDependency {
    /// Register the dependency.
    func register()
}

extension AppDependency {
    /// Register the dependency.
    func register() {
        Resolver.register { self }
    }
}

protocol Configurable {
    associatedtype ConfigurationType
    static var appDefault: ConfigurationType { get }
}
