//
//  UIColor+DesignSystem.swift
//  BackbaseDesignSystemSnapshotTests
//
//  Created by Backbase R&D B.V. on 09/02/2023.
//  Copyright © 2023 Backbase R&D B.V. All rights reserved.
//

import UIKit
import BackbaseDesignSystem

extension UIColor {

    static var designSystemColors: DesignSystem.Colors {
        DesignSystem.shared.colors
    }
}
