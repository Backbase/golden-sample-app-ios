//
//  TransactionsViewModel.swift
//  ios-golden-sample-app
//
//  Created by Tibor Kántor on 11/04/2025.
//

import SwiftUI

@MainActor
class TransactionsViewModel<T>: ObservableObject {
    @Published var state: TransactionsState<T>

    private lazy var intentHandler: TransactionsIntentHandler<T> = {
        TransactionsIntentHandler(setState: { [weak self] newValue in
            self?.state = newValue
        })
    }()

    init(initialState: TransactionsState<T> = TransactionsState<T>.initial) {
        self.state = initialState
    }

    func handleIntent(intent: TransactionsIntent) async {
        await intentHandler.handleIntent(intent)
    }
}
