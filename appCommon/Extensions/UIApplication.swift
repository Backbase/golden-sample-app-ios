//
//  UIApplication.swift
//  AccountsJourney
//
//  Created by Backbase on 03/02/2025.
//

import UIKit

extension UIApplication {
    public var mainKeyWindow: UIWindow? {
        connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .last
    }
}
