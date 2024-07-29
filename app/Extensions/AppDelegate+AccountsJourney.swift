//
//  AppDelegate+AccountsJourney.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 13/10/2023.
//

import Foundation
import Backbase
import Resolver
import AccountsJourney
import GoldenAccountsUseCase

extension AppDelegate {
    func setupAccountsJourney() {
        Resolver.register { CustomAccountListSummaryUseCaseImpl() as AccountsListUseCase}
//        Resolver.register { AccountsListSummaryUseCaseImp(client: self.productSummaryClient) as AccountsListUseCase }
//        Resolver.register { AccountDetailUseCaseImp(client: self.arrangementsClient) as AccountDetailsUseCase}
        Resolver.register { AccountsJourney.Configuration() }
    }
    
    func clientFactory<T: DBSClient>(_ client: T, _ path: String) -> T {
        guard let serverURL: URL = URL(string: Backbase.configuration().backbase.serverURL) else {
            fatalError("Invalid or no serverURL found in the SDK configuration")
        }
        client.baseURL = serverURL.appendingPathComponent(path)
        
        if let dataProvider = Resolver.optional(DBSDataProvider.self) {
            client.dataProvider = dataProvider
            return client
        } else {
            try? Backbase.register(client: client)
            guard let dbsClient = Backbase.registered(client: T.self),
                  let client = dbsClient as? T else {
                fatalError("Failed to retrieve \(T.self) client")
            }
            return client
        }
    }
}
