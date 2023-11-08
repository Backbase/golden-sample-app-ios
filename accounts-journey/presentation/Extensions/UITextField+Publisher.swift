//
//  UITextField+Publisher.swift
//  AccountsJourney
//
//  Created by George Nyakundi on 08/11/2023.
//

import UIKit
import BackbaseDesignSystem
import Foundation
import Combine

extension TextInput {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(
            for: UITextField.textDidChangeNotification,
            object: self.textField
        )
        .compactMap { ($0.object as? UITextField)?.text}
        .eraseToAnyPublisher()
    }
}
