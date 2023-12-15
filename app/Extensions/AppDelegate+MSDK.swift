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
}
