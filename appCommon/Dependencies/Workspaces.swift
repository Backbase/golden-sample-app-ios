//
//  Workspaces.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 31/01/2025.
//

import Resolver
import Backbase
import BackbaseSecureStorage
import BusinessJourneyCommon
import BusinessWorkspacesJourney
import RetailFeatureFilterUseCase
import IdentityAuthenticationJourney
import RetailFeatureFilterAccessControlEntitlementsUseCase
import BusinessWorkspacesJourneyWorkspacesUseCase2
import AccessControlClient3Gen2
import RetailMoreJourney
import BackbaseDesignSystem

// MARK: - Workspace Journey Methods

extension Workspaces.Configuration: AppDependency {
    
    func registerUserRepository() {
        if Resolver.optional(SecureStorageInfo.self) == nil {
            let secureStorageInfo: SecureStorageInfo = SecureStorageFactory.createWithMigration()
            Resolver.register { secureStorageInfo }
        }
        
        let secureStorageInfo: SecureStorageInfo = Resolver.resolve(SecureStorageInfo.self)

        if let migrationError = secureStorageInfo.migrationError  {
            Backbase.logDebug(migrationError, message: "Unable to migrate to secure storage")
        }

        let userRepository = UserRepository(secureStorage: secureStorageInfo.storage)
        Resolver.register { userRepository }
    }
    public func register() {
        let client = clientFactory(defaultClient: UsersAPI(), clientPath: "api/access-control")
        let entitlementsUseCase = AccessControlEntitlementsUseCase(client: client)
        
        Resolver.register { entitlementsUseCase as EntitlementsUseCase }

        let workspacesUseCase = BusinessWorkspacesUseCase()
        Resolver.register { workspacesUseCase as BusinessWorkspacesJourney.WorkspacesUseCase }

        Resolver.register { self }
    }
}

extension Workspaces.Configuration: Configurable {
    public static var appDefault: Workspaces.Configuration = {
        var configuration = Workspaces.Configuration()
        configuration.selector.autoSelectSingleWorkspace = true
        
        let selectWorkspace: ((UINavigationController) -> (WorkspaceInfo) -> Void)? = { navigationController in
            { workspaceInfo in
                didSelectWorkspace(navigationController: navigationController, workspaceInfo: workspaceInfo)
            }
        }
        
        configuration.switcher.router.didSelectWorkspaceV2 = configuration.selector.router.didSelectWorkspaceV2
        return configuration
    }()
    
    static func didSelectWorkspace(navigationController: UINavigationController?, workspaceInfo: WorkspaceInfo) {
        let userRepository = Resolver.resolve(UserRepository.self)
        let authUseCase = Resolver.resolve(AuthenticationUseCase.self)
        
        userRepository.user.name = authUseCase.cachedName ?? ""
        userRepository.user.serviceAgreementIdentifier = workspaceInfo.workspace.id
        userRepository.user.serviceAgreementName = workspaceInfo.workspace.name
        
        if let identifier = workspaceInfo.workspace.additions?[UserRepository.Keys.targetLegalEntityIdentifier.rawValue] {
            userRepository.targetLegalEntityIdentifier = identifier
        } else {
            userRepository.targetLegalEntityIdentifier = nil
            userRepository.persistedServiceAgreementName = workspaceInfo.workspace.name
            userRepository.persistedServiceAgreementIdentifier = workspaceInfo.workspace.id
        }
        
        // Reset Resolver cache so we can create new configuration for the update context
        Resolver.cached.reset()
    }
        
}
