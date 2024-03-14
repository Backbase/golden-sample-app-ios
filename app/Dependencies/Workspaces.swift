//
//  AppDelegate+Workspaces.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 13/10/2023.
//

import Resolver
import Backbase
import IdentityAuthenticationJourney
import BusinessWorkspacesJourney
import BusinessJourneyCommon
import BusinessWorkspacesJourneyWorkspacesUseCase2
import RetailFeatureFilterUseCase
import RetailFeatureFilterAccessControlEntitlementsUseCase
import AccessControlClient3Gen2
import BackbaseDesignSystem
import AccountsJourney
import GoldenAccountsUseCase

// MARK: - Workspaces Journey methods
extension Workspaces.Configuration: AppDependency {
    func register() {
        let userRepository = getUserRepository()
        Resolver.register { userRepository }

        let client = getAccessControlClient()
        Resolver.register { AccessControlEntitlementsUseCase(client: client) as EntitlementsUseCase }

        Resolver.register { BusinessWorkspacesUseCase() as BusinessWorkspacesJourney.WorkspacesUseCase }

        Resolver.register { self }
    }

    func getUserRepository() -> UserRepository {
        let storagePlugin = Backbase.registered(plugin: EncryptedStorage.self)
        guard let storage = (storagePlugin as? EncryptedStorage)?.storageComponent else {
            fatalError("Unable to case storagePlugin as EncryptedStorage")
        }
        return UserRepository(storageComponent: storage)
    }

    func getAccessControlClient() -> AccessControlClient3Gen2.UsersAPI {
        if let dbsClient = Backbase.registered(client: UsersAPI.self), let client = dbsClient as? UsersAPI {
            return client
        } else if let client = Resolver.optional(UsersAPI.self) {
            return client
        } else {
            guard let serverURL = URL(string: Backbase.configuration().backbase.serverURL) else {
                fatalError("Invalid or no serverURL found in the SDK configuration.")
            }

            let newServerURL = serverURL
                .appendingPathComponent("api")
                .appendingPathComponent("access-control")

            let client = UsersAPI()
            client.baseURL = newServerURL

            if let dataProvider = Resolver.optional(DBSDataProvider.self) {
                client.dataProvider = dataProvider
                return client
            } else {
                try? Backbase.register(client: client)
                guard let dbsClient = Backbase.registered(client: UsersAPI.self),
                      let client = dbsClient as? UsersAPI else {
                    fatalError("Failed to retrieve \(UsersAPI.self) client")
                }
                return client
            }
        }
    }
}

extension Workspaces.Configuration: Configurable {
    static var appDefault: Workspaces.Configuration {
        var configuration = Workspaces.Configuration()

        configuration.selector.router.didSelectWorkspaceV2 = { _ in
            { workspaceInfo in
                let userRepository = Resolver.resolve(UserRepository.self)
                userRepository.user.serviceAgreementIdentifier = workspaceInfo.workspace.id
                userRepository.user.serviceAgreementName = workspaceInfo.workspace.name
                guard let window = UIApplication.shared.keyWindow else { return }
                Resolver.resolve(AppConfiguration.self).router.didUpdateState(.workspaceSelected)(window)
            }
        }
        
        return configuration
    }
}
