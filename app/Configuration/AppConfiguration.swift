//
//  Created by Backbase R&D B.V. on 13/03/2024
//
    

import Foundation
import Resolver
import IdentityAuthenticationJourney
import AccountsJourney
import BusinessWorkspacesJourney

enum AppState {
    /// The user is not logged in and not enrolled.
    case notLoggedInNotEnrolled
    /// The user is enrolled but not logged in.
    case notLoggedInEnrolled
    /// The user is enrolled and logged in.
    case loggedInEnrolled
    /// The user is completed authentication and selected a workspace.
    case workspaceSelected
    /// The session is expired.
    case sessionExpired
    /// The user's account is locked.
    case accountLocked
}

/// A protocol representing app configuration.
final class AppConfiguration {
    /// App router type.
    let router: AppRouter = AppRouter()

    let authentication: Authentication.Configuration = .appDefault
    let accountsJourney: AccountsJourney.Configuration = .appDefault
    let workspaces: Workspaces.Configuration = .appDefault

    /// Array of `AppDependency` objects to be registered.
    /// Defaults to all properties that conform to the `AppDependency` protocol.
    private var dependencies: [AppDependency] {
        Mirror(reflecting: self)
            .children
            .map(\.value)
            .compactMap { $0 as? AppDependency }
    }

    /// Create new configuration.
    init() {}

    func registerDependencies() {
        dependencies.forEach { $0.register() }
        Resolver.register { self }
    }
}
