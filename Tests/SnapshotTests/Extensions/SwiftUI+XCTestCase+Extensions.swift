//
//  Created by Backbase on 29/02/2024.
//

import SwiftUI
import XCTest
import BackbaseDesignSystem

extension XCTestCase {

    func convertToUIView(from someView: some View) -> UIView {
        let viewController = UIHostingController(rootView: someView)
        viewController.view.backgroundColor = .clear

        let swiftuiView = viewController.view!
        swiftuiView.translatesAutoresizingMaskIntoConstraints = false

        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(swiftuiView)

        NSLayoutConstraint.activate([
            swiftuiView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2),
            swiftuiView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2),
            swiftuiView.topAnchor.constraint(equalTo: view.topAnchor, constant: 2),
            swiftuiView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -2)
        ])

        return view
    }
}
