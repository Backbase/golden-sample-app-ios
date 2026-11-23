//
//  Reusable+UITableViewCell.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 26/10/2023.
//

import UIKit

protocol Reusable {
    typealias Cell = UITableViewCell & Reusable
    static var reuseIdentifier: String { get }
}

extension Reusable where Self: UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: type(of: self))
    }
}

extension UITableView {
    func registerCell<C: Reusable.Cell>(_ cellType: C.Type) {
        register(C.self, forCellReuseIdentifier: C.reuseIdentifier)
    }
    
    func dequeReusableCell<C: Reusable.Cell>(_ cellType: C.Type) -> C {
        guard let cell = dequeueReusableCell(withIdentifier: cellType.reuseIdentifier) as? C else {
            fatalError("Unable to dequeue reusable cell of type `\(cellType)`")
        }
        return cell
    }
}
