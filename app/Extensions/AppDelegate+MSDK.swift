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
            try Backbase.initialize("config.json", forceDecryption: false)
        } catch {
            fatalError("Backbase MSDK initialization failed: \(error.localizedDescription)")
        }
    }

    func appendCustomHeader() {
        if let defaultHTTPHeaders = Backbase.configuration().custom["default-http-headers"] as? [String: String] {
            var backbaseHeaders = Backbase.securitySessionConfiguration().httpAdditionalHeaders ?? [:]
                for (key, value) in defaultHTTPHeaders {
                    backbaseHeaders.updateValue(value, forKey: key)
                }
            Backbase.securitySessionConfiguration().httpAdditionalHeaders = backbaseHeaders
        }
    }
}
