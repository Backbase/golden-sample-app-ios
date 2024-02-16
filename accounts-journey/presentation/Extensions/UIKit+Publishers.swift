//
//  UISearchController+Publisher.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 08/11/2023.
//

import UIKit
import Foundation
import Combine

extension UISearchBar {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(
            for: UITextField.textDidChangeNotification,
            object: self.searchTextField
        )
        .compactMap { ($0.object as? UITextField)?.text}
        .eraseToAnyPublisher()
    }
}
