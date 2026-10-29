//
//  AccountsListConfiguration.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 11/10/2023.
//

import Foundation

extension AccountsList {
    public struct Configuration {
        /// Create a new Configuration object with default values
        public init() {
            // no code required
        }
        /// Configuration of the design used in Accounts List
        public var design = Design()
        /// Configuration of strings used in Accounts List
        public var strings = Strings()
        /// Configuration for router of Accounts List
        public var router = Router(
            didSelectProduct: { navigationController in
                return { arrangementId in
                    // The selection handlers are called from the accounts list UI, always on the main thread.
                    MainActor.assumeIsolated {
                        let viewController = AccountDetails.build(
                            navigationController: navigationController,
                            arrangementId: arrangementId
                        )
                        navigationController.pushViewController(viewController, animated: true)
                    }
                }
            }
        )
    }
}
