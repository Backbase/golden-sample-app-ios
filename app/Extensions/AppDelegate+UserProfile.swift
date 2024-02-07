//
//  Created by Backbase on 07/02/2024.
//

import Resolver
import Backbase
import UserManagerClient2
import UserProfileJourney
import UserManagerUserProfileUseCase

extension AppDelegate {
    func setupUserProfileUseCase() {
        if Resolver.optional(UserProfileUseCase.self) == nil {
            let userProfileUseCase = UserManagerUserProfileUseCase(client: getUserProfileClient())
            Resolver.register { userProfileUseCase as UserProfileUseCase }
        }
    }

    private func getUserProfileClient() -> UserProfileManagementAPIProtocol {
        guard let serverURL = URL(string: Backbase.configuration().backbase.serverURL) else {
            fatalError("Invalid or no serverURL found in the SDK configuration.")
        }

        let userManagerUrl = serverURL
            .appendingPathComponent("api")
            .appendingPathComponent("user-manager")

        let client = UserProfileManagementAPI()
        client.baseURL = userManagerUrl

        if let dataProvider = Resolver.optional(DBSDataProvider.self) {
            client.dataProvider = dataProvider
            return client
        } else {
            try? Backbase.register(client: client)
            guard let dbsClient = Backbase.registered(client: UserProfileManagementAPI.self),
                  let client = dbsClient as? UserProfileManagementAPI
            else {
                fatalError("Failed to retrieve User Manager client")
            }
            return client
        }
    }
}
