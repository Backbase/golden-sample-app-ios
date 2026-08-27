//
//  Created by Backbase on 19/02/2024.
//

import UIKit
import BackbaseDesignSystem

protocol CellCornerModifier: UITableViewCell {
    func setupCornerRadius(position: CellPosition)
}

extension CellCornerModifier {
    func setupCornerRadius(position: CellPosition) {
        let view = UIView()
        let color = UIColor(light: Theme.colors.background.brandSubtle, dark: Theme.colors.background.brand)
        view.backgroundColor = color
        view.layer.cornerRadius = DesignSystem.shared.cornerRadius.large
        view.layer.maskedCorners = position.maskedCorners
        selectedBackgroundView = view

        layer.cornerRadius = DesignSystem.shared.cornerRadius.large
        layer.maskedCorners = position.maskedCorners
    }
}

enum CellPosition {
    case beginning
    case end
    case middle
    case full

    var cornerRadius: CGFloat {
        self == .middle ? 0 : DesignSystem.shared.cornerRadius.large
    }

    var maskedCorners: CACornerMask {
        switch self {
        case .beginning:
            return [
                .layerMinXMinYCorner,
                .layerMaxXMinYCorner
            ]
        case .end:
            return [
                .layerMinXMaxYCorner,
                .layerMaxXMaxYCorner
            ]
        case .full:
            return [
                .layerMinXMinYCorner,
                .layerMaxXMinYCorner,
                .layerMinXMaxYCorner,
                .layerMaxXMaxYCorner
            ]
        default:
            return []
        }
    }
}
