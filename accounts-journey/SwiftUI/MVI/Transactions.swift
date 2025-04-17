//
//  Transactions.swift
//  ios-golden-sample-app
//
//  Created by Nathan Wong on 17/04/2025.
//

import SwiftUI
import UIKit

public struct Transactions {
    public static func build(configuration: TransactionsConfiguration) -> UIViewController {
        return UIHostingController(rootView: TransactionsView(configuration: configuration))
    }
}
