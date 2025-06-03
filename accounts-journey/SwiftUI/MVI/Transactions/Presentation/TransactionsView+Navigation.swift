import SwiftUI
import UIKit

public extension TransactionsView {

    static func build(navigationController: UINavigationController) -> UIViewController {
        let view = TransactionsView()
        let viewController = UIHostingController(rootView: view)
        viewController.title = "Transactions"
        return viewController
    }
}
