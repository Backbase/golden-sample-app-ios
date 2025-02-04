//
//  AppDependency+ClientFactory.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 31/01/2025.
//

import Foundation
import Backbase
import Resolver

extension AppDependency {
    public func clientFactory<T: DBSClient>(defaultClient: T, clientPath: String) -> T {
        guard let serverURL = URL(string: Backbase.configuration().backbase.serverURL) else {
            fatalError("Invalid or no serverURL found in the SDK configuration.")
        }

        let client = defaultClient
        client.baseURL = serverURL.appendingPathComponent(clientPath)
        client.dataProvider = Resolver.optional(DBSDataProvider.self) ?? BBNetworkDataProvider()
        return client
    }
}
