//
//  AppDependency.swift
//  AppCommon
//
//  Created by George Nyakundi on 31/01/2025.
//

import Foundation
import Resolver

/// A protocol representing a dependency for the app.
public protocol AppDependency {
    /// Register the dependency
    func register()
}

extension AppDependency {
    /// Default implementation to allow for registration of the dependency
    public func register() {
        Resolver.register { self }
    }
}

public protocol Configurable {
    associatedtype ConfigurationType
    static var appDefault: ConfigurationType { get }
}
