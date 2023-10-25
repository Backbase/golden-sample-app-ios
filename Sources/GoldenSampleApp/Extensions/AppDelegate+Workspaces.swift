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
import AccountsJourney
import GoldenAccountsUseCase



// MARK: - Workspaces Journey methods

extension AppDelegate {
    func setupWorkspacesJourney() {
        
        let userRepository = getUserRepository()
        Resolver.register { userRepository }
        
        let configuration = getWorkspacesConfiguration()
        Resolver.register { configuration }
        
        let client = getAccessControlClient()
        Resolver.register { AccessControlEntitlementsUseCase(client: client) as EntitlementsUseCase }
        
        Resolver.register { BusinessWorkspacesUseCase() as BusinessWorkspacesJourney.WorkspacesUseCase }
    }
    
    func getWorkspacesConfiguration() -> Workspaces.Configuration {
        var configuration = Workspaces.Configuration()
        let didSelect = configuration.selector.router.didSelectWorkspaceV2
        
        configuration.selector.router.didSelectWorkspaceV2 = { [weak self] navigationController in
            { [weak self] workspace in
                didSelect?(navigationController)(workspace)
                self?.window?.rootViewController = AccountsJourney.build()
                self?.window?.makeKeyAndVisible()
            }
        }
        
        configuration.switcher.router.didSelectWorkspaceV2 = configuration.selector.router.didSelectWorkspaceV2
        
        return configuration
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
