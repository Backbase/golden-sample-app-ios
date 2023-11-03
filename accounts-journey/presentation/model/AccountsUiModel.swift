//
//  AccountsUiModel.swift
//  AccountsJourney
//
//  Created by George Nyakundi on 26/10/2023.
//

import Foundation

struct AccountsUiModel {
    var header: String
    var products: [AccountUiModel]
    
    init(header: String = "", products: [AccountUiModel] = []) {
        self.header = header
        self.products = products
    }
}
