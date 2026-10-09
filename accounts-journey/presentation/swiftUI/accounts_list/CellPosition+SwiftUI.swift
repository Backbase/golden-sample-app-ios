//
//  CellPosition+SwiftUI.swift
//  AccountsJourney
//

import BackbaseDesignSystem
import SwiftUI

extension CellPosition {

    /// Position of a row inside a grouped list.
    static func position(forRow index: Int, count: Int) -> CellPosition {
        if count < 2 {
            return .full
        }
        if index == 0 {
            return .beginning
        }
        if index == count - 1 {
            return .end
        }
        return .middle
    }

    /// SwiftUI corner radii equivalent of `maskedCorners`.
    func cornerRadii(radius: CGFloat = DesignSystem.shared.cornerRadius.large) -> RectangleCornerRadii {
        switch self {
        case .beginning:
            return RectangleCornerRadii(topLeading: radius, bottomLeading: 0, bottomTrailing: 0, topTrailing: radius)
        case .end:
            return RectangleCornerRadii(topLeading: 0, bottomLeading: radius, bottomTrailing: radius, topTrailing: 0)
        case .full:
            return RectangleCornerRadii(topLeading: radius, bottomLeading: radius, bottomTrailing: radius, topTrailing: radius)
        case .middle:
            return RectangleCornerRadii()
        }
    }
}
