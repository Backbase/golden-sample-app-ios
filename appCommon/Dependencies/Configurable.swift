//
//  Configurable.swift
//  AppCommon
//
//  Created by Backbase on 07/02/2025.
//

import Foundation

/**
 *  A protocol defining a type that can be configured.
 *
 *  Types conforming to this protocol provide a way to be configured, typically
 *  during initialization or setup.  They define an associated type,
 *  `ConfigurationType`, which specifies the type of configuration data they
 *  use.  Furthermore, they provide a static property, `appDefault`, which
 *  returns a default configuration instance suitable for general use within
 *  the application.
 */
public protocol Configurable {
    /// The type of configuration data used by this type.
    associatedtype ConfigurationType
    
    /// A default configuration instance suitable for general application use.
    ///
    /// This static property provides a pre-configured instance of
    /// `ConfigurationType` that represents reasonable defaults for the type.
    /// It can be used as a starting point for customization or as a fallback
    /// when specific configuration data is not available.
    static var appDefault: ConfigurationType { get }
}
