import SwiftUI

public struct NewTransactionView: View {
    var body: some View {
        Text("New Transaction")
    }
}

public extension NewTransactionView {
    static func build(navigationController: UINavigationController) -> UIViewController {
        let view = NewTransactionView()
        let viewController = UIHostingController(rootView: view)
        viewController.title = "New transaction"
        return viewController
    }
}
