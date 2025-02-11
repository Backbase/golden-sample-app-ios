//
//  AppDependency.swift
//  AppCommon
//
//  Created by Backbase on 31/01/2025.
//

import Foundation
import Resolver

/**
 *  A protocol defining the registration of an application dependency.
 *
 *  This protocol outlines the requirement for a type to register itself as a
 *  dependency within the application's dependency injection system or
 *  similar mechanism.  It provides a single method, `register()`, which
 *  should be called to perform the actual registration.
 */
public protocol AppDependency {
    /// Registers the dependency within the application.
    ///
    /// This method is responsible for performing the necessary actions to make
    /// the dependency available for use by other components of the application.
    /// This might involve registering the dependency with a dependency
    /// injection container, setting up necessary configurations, or performing
    /// other initialization steps.
    func register()
}

extension AppDependency {
    public func register() {
        Resolver.register { self }
    }
}
