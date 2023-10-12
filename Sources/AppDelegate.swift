//
//  AppDelegate.swift
//  ios-golden-sample-app
//
//  Created by Backbase on 29/06/2023.
//

import UIKit
import Resolver
import Backbase
import IdentityAuthenticationJourney
import BusinessWorkspacesJourney
import BusinessWorkspacesJourneyWorkspacesUseCase2
import BusinessJourneyCommon
import RetailFeatureFilterUseCase
import RetailFeatureFilterAccessControlEntitlementsUseCase
import AccessControlClient3Gen2

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // MARK: Identity Journey properties

    private lazy var authenticationUseCase: IdentityAuthenticationUseCase = { [weak self] in
        let usecase = IdentityAuthenticationUseCase(sessionChangeHandler: self?.handleSessionChange(newSession:))
        Backbase.register(authClient: usecase)

        Resolver.register { Authentication.Configuration() }
        Resolver.register { usecase as AuthenticationUseCase }

        return usecase
    }()

    private lazy var authenticationConfiguration: Authentication.Configuration = {
        var config = Authentication.Configuration()
        config.login.autoLoginEnabled = true
        return config
    }()

    private lazy var navCoordinator: AuthenticationNavigationCoordinator = { [weak self] in
        guard let window = self?.window else { fatalError("Failed to get window") }
        return Authentication.NavigationCoordinator(window: window)
    }()

    // MARK: Default methods

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow()
        window.rootViewController = UIViewController()
        window.makeKeyAndVisible()
        self.window = window

        setupBackbaseSDK()
        setupIdentityJourney()
        setupWorkspacesJourney()
        return true
    }
}

// MARK: Backbase SDK methods
private extension AppDelegate {
    func setupBackbaseSDK() {

        do {
            try Backbase.initialize("config.json", forceDecryption: false)
        } catch {
            fatalError("Backbase MSDK initialization failed: \(error.localizedDescription)")
        }

    }
}

// MARK: Identity Journey methods

private extension AppDelegate {

    func setupIdentityJourney() {
        Resolver.register { self.navCoordinator as AuthenticationNavigationCoordinator }
        authenticationUseCase.initializeNavigationEventListener()
        authenticationUseCase.validateSession()
    }

    func handleSessionChange(newSession session: Session) {
        DispatchQueue.main.async {
            let windowViewController: UIViewController
            let navigationController = UINavigationController()

            switch session {
            case .valid:
                windowViewController = Workspaces.buildSelector(navigationController: navigationController)
            case .none:
                if self.authenticationUseCase.isEnrolled {
                    windowViewController = Login.build(shouldAutoLogin: true)(navigationController)
                } else {
                    windowViewController = Register.build()(navigationController)
                }
            case .locked:
                windowViewController = Register.build(session: .locked)(navigationController)
            case .expired:
                windowViewController = Login.build(session: .expired)(navigationController)
            @unknown default:
                fatalError()
            }
            navigationController.viewControllers = [windowViewController]
            self.window?.rootViewController = navigationController
        }
    }
}

// MARK: - Workspaces Journey methods

private extension AppDelegate {
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
    
//    func get

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
