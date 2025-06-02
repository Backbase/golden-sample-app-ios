import SwiftUI
import UIKit

public extension TransactionsView {
    /// Main entry point to the AccountsList
    /// - Returns: a UIViewController
    /// - Parameter navigationController: UINavigationController
    static func build(navigationController: UINavigationController) -> UIViewController {
        let view = TransactionsView()
        let viewController = UIHostingController(rootView: view)
        viewController.title = "Transactions"
        return viewController
    }
}
