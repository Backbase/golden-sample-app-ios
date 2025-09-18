//
//  AppDelegate+MSDK.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 13/10/2023.
//

import Backbase

// MARK: Backbase SDK methods
extension AppDelegate {
    func setupBackbaseSDK() {
        do {
            let configuration = BBConfiguration()

            let identityConfig = BBIdentityConfiguration(
                baseURL: "https://identity.dev.sdbxaz.azure.backbaseservices.com",
                realm: "retail",
                clientId: "mobile-client",
                applicationKey: "retail"
            )
            configuration.backbase = BBBackbaseConfiguration(
                serverURL: "https://app.dev.sdbxaz.azure.backbaseservices.com",
                version: "6.1.5",
                identity: identityConfig
            )
            configuration.security = BBSecurityConfiguration(
                allowedDomains: ["*"]
            )
            configuration.bankTimeZone = "Europe/Amsterdam"
            configuration.persistentHeaders = [
                "default-http-headers": ["X-SDBXAZ-API-KEY": "Add your API key here"],
            ]
            try Backbase.initialize(fromConfig: configuration)
            appendCustomHeader()
        } catch {
            fatalError("Backbase MSDK initialization failed: \(error.localizedDescription)")
        }
    }

    func appendCustomHeader() {
        if let defaultHTTPHeaders = Backbase.configuration().persistentHeaders["default-http-headers"] as? [String: String] {
            var backbaseHeaders = Backbase.securitySessionConfiguration().httpAdditionalHeaders ?? [:]
                for (key, value) in defaultHTTPHeaders {
                    backbaseHeaders.updateValue(value, forKey: key)
                }
            Backbase.securitySessionConfiguration().httpAdditionalHeaders = backbaseHeaders
        }
    }
}
