//
//  CustomRouterStrings.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 8/05/2025.
//

import IdentityAuthenticationJourney

extension CustomRouter {
    public struct Strings {
        public init() {
            // no code required
        }

        /// authentication.registration.custom.alertTitle
        public var alertTitle = localized(key: "alertTitle")
        /// authentication.registration.custom.alertMessage
        public var alertMessage = localized(key: "alertMessage")
        /// authentication.registration.custom.closeButton
        public var closeButton = localized(key: "closeButton")
        /// authentication.registration.custom.continueButton
        public var continueButton = localized(key: "continueButton")

        // MARK: - Private
        private static func localized(key: String) -> LocalizedString {
            let prefix = "authentication.registration.custom."
            return LocalizedString(key: prefix + key, in: .appCommon)
        }
    }
}
