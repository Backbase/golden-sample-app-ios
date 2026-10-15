//
//  AccountsData.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 26/10/2023.
//

import Foundation

struct AccountsData {
    var header: String
    var products: [AccountData]
    
    init(header: String = "", products: [AccountData] = []) {
        self.header = header
        self.products = products
    }
}
