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
        Resolver.register { AccountsSummaryUseCaseImp(client: self.productSummaryClient) as AccountsUseCase }
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
                fatalError("Failed to retrieve \(T.self) cliet")
            }
            return client
        }
    }
}
