import SwiftUI
import UIKit

public struct NewTransactionView: View {
    public var body: some View {
        Text("New Transaction")
    }
}

extension NewTransactionView {
    static func build(navigationController: UINavigationController) -> UIViewController {
        let view = NewTransactionView()
        let viewController = UIHostingController(rootView: view)
        viewController.title = "New transaction"
        return viewController
    }
}
