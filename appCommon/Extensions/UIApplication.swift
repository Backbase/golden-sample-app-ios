//
//  UIApplication.swift
//  AccountsJourney
//
//  Created by Backbase on 03/02/2025.
//

import UIKit

extension UIApplication {
    ///
    /// The main key window of the application.
    ///
    /// This computed property returns the current key window of the application.
    /// It iterates through the connected scenes and finds the last key window
    /// associated with a `UIWindowScene`.  This approach handles cases where
    /// multiple scenes might be connected, ensuring the correct key window is
    /// retrieved.  It returns `nil` if no key window is found.
    ///
    public var mainKeyWindow: UIWindow? {
        connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .last
    }
}
