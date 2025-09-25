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
                baseURL: BBConfigurationConstants.identityBaseURL,
                realm: BBConfigurationConstants.realm,
                clientId: BBConfigurationConstants.clientId,
                applicationKey: BBConfigurationConstants.applicationKey
            )
            configuration.backbase = BBBackbaseConfiguration(
                serverURL: BBConfigurationConstants.backbaseServerURL,
                version: BBConfigurationConstants.version,
                identity: identityConfig
            )
            configuration.security = BBSecurityConfiguration(
                allowedDomains: BBConfigurationConstants.allowedDomains
            )
            configuration.bankTimeZone = BBConfigurationConstants.bankTimeZone
            try Backbase.initialize(fromConfig: configuration)
            appendCustomHeader()
        } catch {
            fatalError("Backbase MSDK initialization failed: \(error.localizedDescription)")
        }
    }

    func appendCustomHeader() {
        var backbaseHeaders = Backbase.securitySessionConfiguration().httpAdditionalHeaders ?? [:]
        backbaseHeaders["X-SDBXAZ-API-KEY"] = BBConfigurationConstants.apiKey
        Backbase.securitySessionConfiguration().httpAdditionalHeaders = backbaseHeaders
    }
}
