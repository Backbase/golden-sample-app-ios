//
//  main.swift
//  GoldenSampleApp
//
//  Created by Backbase on 04/02/2025.
//
// We have to keep this file names as `main.swift` because: https://developer.apple.com/swift/blog/?id=7

import Foundation
import AppCommon
import UIKit

/**
 * The entry point for the application.
 *
 * This function is the first code executed when the application launches.  It
 * sets up the application's main run loop, creates the application and
 * application delegate instances, and begins event handling.  It effectively
 * starts the entire iOS application lifecycle.
 *
 * - Parameters:
 *   - argc: The number of command-line arguments.
 *   - argv: A pointer to an array of C-style strings representing the
 *     command-line arguments.
 *   - principalClassName: The name of the class to use as the application
 *     object.  Here, `AppCommon.Application.self` is used.
 *   - delegateClassName: The name of the class to use as the application's
 *     delegate. Here, `AppDelegate.self` is used.
 */
UIApplicationMain(
    CommandLine.argc,
    CommandLine.unsafeArgv,
    NSStringFromClass(AppCommon.Application.self),
    NSStringFromClass(AppDelegate.self)
)
