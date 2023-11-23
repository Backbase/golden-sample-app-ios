//
//  AccountsUIModel.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 26/10/2023.
//

import Foundation

struct AccountsUIModel {
    var header: String
    var products: [AccountUIModel]
    
    init(header: String = "", products: [AccountUIModel] = []) {
        self.header = header
        self.products = products
    }
}
