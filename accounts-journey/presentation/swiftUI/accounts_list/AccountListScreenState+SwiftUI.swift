//
//  AccountListScreenState+SwiftUI.swift
//  ios-golden-sample-app
//
//  Created by Aleh Pachtovy on 09/10/2026.
//

extension AccountListScreenState {

    var isLoading: Bool {
        if case .loading = self { return true }
        return false
    }

    var isError: Bool {
        if case .hasError = self { return true }
        return false
    }
}
