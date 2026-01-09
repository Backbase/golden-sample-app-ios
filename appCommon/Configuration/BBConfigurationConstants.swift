//
//  BBConfigurationConstants.swift
//  ios-golden-sample-app
//
//  Created by Sadiq Mohammad on 24/09/25.
//

struct BBConfigurationConstants {
    static let version = "6.1.5"
    static var apiKey = "Add your API key here"
    static let identityBaseURL = "https://identity.prd.sdbxaz.azure.backbaseservices.com"
    static let backbaseServerURL = "https://app.prd.sdbxaz.azure.backbaseservices.com"
    static let peristentHeaders = [
        "X-User-Context": ["backbaseservices.com"]
    ]
    static let realm = "retail"
    static let clientId = "mobile-client"
    static let applicationKey = "retail"
    static let bankTimeZone = "Europe/Amsterdam"
    static let allowedDomains = ["*"]
}
