//
//  AppDependency+ClientFactory.swift
//  GoldenSampleApp
//
//  Created by Backbase on 31/01/2025.
//

import Foundation
import Backbase
import Resolver

extension AppDependency {
    ///
    /// Creates and returns a DBSClient.
    ///
    /// This function returns a DBSClient. If a client for the given path
    /// already exists, it returns that client; otherwise, it creates a new
    /// client using the provided default client and path.
    ///
    /// - Parameters:
    /// - defaultClient: The default DBSClient to use if one doesn't exist for the given path.
    /// - clientPath: The path to the DBSClient.
    ///
    /// - Returns: A DBSClient.
    ///
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
