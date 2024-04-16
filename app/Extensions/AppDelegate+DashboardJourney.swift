//
//  Created by Backbase on 12/03/2024.
//

import Resolver
import DashboardJourney
import RetailAccountsAndTransactionsJourney
import RetailAccountsAndTransactionsJourneyAccountsUseCase
import RetailAccountsAndTransactionsArrangementViewsUseCase
import RetailAccountsAndTransactionsJourneyTransactionsUseCase

// MARK: - Dashboard Journey methods
extension AppDelegate {
    func setupDashboardJourney() {
        let configuration = getConfiguration()
        Resolver.register { configuration }
        setupUseCaseDependencies()
    }
}

private extension AppDelegate {
    func getConfiguration() -> Dashboard.Configuration {
        var config = Dashboard.Configuration()

        config.dashboardList.items = { navigation in {
            [
                DashboardTileFactory.makeTotalBalanceTile(navigation),
                DashboardTileFactory.makeAccountsTile(navigation),
                DashboardTileFactory.makeLatestTransactionsTile(navigation)
            ].compactMap { $0 }
            }
        }
        return config
    }

    func setupUseCaseDependencies() {
        let accountsUseCase = RetailAccountsUseCase(productSummarClient: self.productSummaryClient,
                                                    accountsClient: self.arrangementsClient)
        if Resolver.optional(RetailAccountsAndTransactionsJourney.ArrangementsUseCase.self) == nil {
            Resolver.register { accountsUseCase as RetailAccountsAndTransactionsJourney.ArrangementsUseCase }
        }

        if Resolver.optional(AccountsUseCase.self) == nil {
            Resolver.register { accountsUseCase as AccountsUseCase }
        }

        if Resolver.optional(ArrangementViewsUseCase.self) == nil {
            let arrangementsViewUseCase = RetailArrangementsViewsUseCase()
            Resolver.register { arrangementsViewUseCase as ArrangementViewsUseCase }
        }

        if Resolver.optional(RetailAccountsAndTransactionsJourney.TransactionsUseCase.self) == nil {
            let transactionsUseCase = RetailTransactionsUseCase(client: self.transactionsClient)
            Resolver.register { transactionsUseCase
                as RetailAccountsAndTransactionsJourney.TransactionsUseCase
            }
        }
    }
}
