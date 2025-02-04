//
//  main.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 04/02/2025.
//
// We have to keep this file names as `main.swift` because: https://developer.apple.com/swift/blog/?id=7

import Foundation
import AppCommon
import UIKit

UIApplicationMain(
    CommandLine.argc,
    CommandLine.unsafeArgv,
    NSStringFromClass(AppCommon.Application.self),
    NSStringFromClass(AppDelegate.self)
)
