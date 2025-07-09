//
//  UIConstants.swift
//  GoldenSampleUITests
//
//  Created by Backbase on 15/12/2023.
//

import Foundation

enum Timeouts {
    static let shorterTimeout: TimeInterval = 3.0
    static let shortTimeout: TimeInterval = 5.0
    static let defaultTimeout: TimeInterval = 15.0
    static let averageTimeout: TimeInterval = 10.0
    static let requestTimeout: TimeInterval = 30.0
    static let authTimeout: TimeInterval = 60.0
    static let sessionTimeout: TimeInterval = 300.0
}

enum Pagination {
    static let amount: Int = 10
}

enum UIStatus: String {
    case exist = "exists == true"
    case notExist = "exists == false"
    case selected = "selected == true"
    case notSelected = "selected == false"
    case hittable = "isHittable == true"
    case notHittable = "isHittable == false"
    case isLabelEqual = "label MATCHES '%@'"
    case isPlaceholderEqual = "placeholderValue MATCHES '%@'"
}
