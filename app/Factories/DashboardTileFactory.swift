//
//  Created by Backbase on 12/03/2024.
//

import UIKit
import DashboardJourneyCore
import DashboardJourney
import Resolver
import RetailFeatureFilterUseCase
import RetailAccountsAndTransactionsJourney

class DashboardTileFactory {
    // MARK: - Properties
    @LazyInjected
    private static var useCase: FeatureFilterUseCase
    private static var allowedFeatures: [DashboardCore.Entitlement] = []
    private static let featureMap: [String: UserEntitlement] = {
        let values: [(String, UserEntitlement)] = (
            QuickActionsTile.entitlements +
            LatestTransactionsTile.entitlements
        )
            .map { $0.toUserEntitlement() }
            .map { $0.toFeature() }

        return Dictionary(uniqueKeysWithValues: values)
    }()

    private static func handleAllowedFeatures(_ features: [String]) {
        Self.allowedFeatures = Self.featureMap
            .filter { features.contains($0.key) }
            .map { $0.value.toDashboardEntitlement() }
    }

    static func loadFeatures() async {
        await withCheckedContinuation { continuation in
            useCase.filterToCachedAllowedFeatures(Self.featureMap) { result in
                switch result {
                case let .success(allowedFeatures):
                    Self.handleAllowedFeatures(allowedFeatures)
                case .failure:
                    Self.handleAllowedFeatures(Self.featureMap.map { $0.key })
                }
                continuation.resume()
            }
        }
    }

    private func checkEntitlements(_ entitlements: [DashboardCore.Entitlement]) -> Bool {
        guard !entitlements.isEmpty else { return true }
        return !Self.allowedFeatures.filter { entitlements.contains($0) }.isEmpty
    }

    // MARK: - Methods
    func makeLatestTransactionsTile(_ parentNavigationController: UINavigationController) -> (any TileProtocol)? {
        guard checkEntitlements(LatestTransactionsTile.entitlements) else {
            return nil
        }
        let tile = LatestTransactionsTile.build(navigationController: parentNavigationController)
        return tile
    }

    func makeAccountsTile(_ parentNavigationController: UINavigationController) -> (any TileProtocol)? {
        let tile = RetailAccountsAndTransactionsJourney.AccountsTile.build(
            navigationController: parentNavigationController
        )
        return tile
    }

    func makeTotalBalanceTile(_ parentNavigationController: UINavigationController) -> (any TileProtocol)? {
        let tile = TotalBalanceTile.build(navigationController: parentNavigationController)
        return tile
    }
}

// MARK: - Mappers
private extension UserEntitlement {
    func toFeature() -> (String, UserEntitlement) {
        (identifier, self)
    }

    func toDashboardEntitlement() -> DashboardCore.Entitlement {
        .init(resourceName: resource,
              businessFunction: function,
              privilege: privilege)
    }
}

private extension DashboardCore.Entitlement {
    func toUserEntitlement() -> UserEntitlement {
        .init(resource: resourceName,
              function: businessFunction,
              privilege: privilege)
    }
}
