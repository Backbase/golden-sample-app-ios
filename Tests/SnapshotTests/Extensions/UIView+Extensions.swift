//
//  Created by Backbase on 8.12.2022.
//

import UIKit
import BackbaseDesignSystem

extension UIView {

    func setSizeConstraints(size: CGSize) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: size.width),
            self.heightAnchor.constraint(equalToConstant: size.height)
        ])
        return self
    }

    func containerCenterAligned(size: CGSize = CGSize(width: 200, height: 100),
                                backgroundColor: UIColor = DesignSystem.shared.colors.surfaceSecondary.default) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        let view = containerView(size: size, backgroundColor: backgroundColor)
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        return view
    }

    func containerCornerAttached(size: CGSize = CGSize(width: 200, height: 100),
                                 backgroundColor: UIColor = DesignSystem.shared.colors.surfaceSecondary.default) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        let view = containerView(size: size, backgroundColor: backgroundColor)
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        return view
    }

    private func containerView(size: CGSize, backgroundColor: UIColor) -> UIView {
        let containerView = UIView(frame: .init(origin: .zero, size: size))
        containerView.backgroundColor = backgroundColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = 8.0
        containerView.addSubview(self)
        return containerView
    }
}
