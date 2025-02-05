//
//  Created by Backbase on 13/02/2024.
//

import Resolver
import Backbase
import AppCommon
import UserManagerClient2
import UserProfileJourney
import UserManagerUserProfileUseCase

/// A helper struct to setup UserProfileUseCase.
///

extension UserManagerUserProfileUseCase: AppCommon.AppDependency {
    public func register() {
        if Resolver.optional(UserProfileUseCase.self) == nil {
            
            let userProfileClient = clientFactory(defaultClient: UserProfileManagementAPI(), clientPath: "api/user-manager")
            
            let userProfileUseCase = UserManagerUserProfileUseCase(client: userProfileClient)
            Resolver.register { userProfileUseCase as UserProfileUseCase }
        }
    }
}
