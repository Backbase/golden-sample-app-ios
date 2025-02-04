//
//  SplashConfiguration.swift
//  AppCommon
//
//  Created by George Nyakundi on 04/02/2025.
//

import UIKit
import Resolver
import BackbaseAnimation

public extension Splash {
    /// A structure that represents the sources of animations for both light and dark modes along with their duration.
    ///
    /// This struct is designed to encapsulate the animation sources for the splash screen of an application,
    /// allowing for a seamless transition between light and dark modes by specifying separate source..
    /// Additionally, it allows for the specification of a duration for the animation, defaulting to 2 seconds if not specified.
    struct SplashAnimationSource {
        /// The animation source to be used in animation.
        let source: AnimationSource
        
        /// The duration of the animation in seconds. Defaults to 2 seconds.
        let duration: Double
        
        /// Initializes a new `SplashAnimationSource` with the same animation source for both light and dark modes.
        ///
        /// This initializer is useful when the same animation is appropriate for both modes, simplifying the setup.
        /// - Parameters:
        ///   - source: The `AnimationSource` to be used for both light and dark modes using `AnimationEnvironment`.
        ///   - duration: The duration of the animation in seconds. Defaults to 2 seconds if not explicitly specified.
        public init(source: AnimationSource, duration: Double = 2) {
            self.source = source
            self.duration = duration
        }
    }

    /// An enum to represent type of splash screen type
    enum SplashScreenType {
        /// Show static image splash screen
        case stationary
        /// Show animated splash screen using given json source and background color.
        /// The `SplashAnimationSource` can be configured for a single file and configure `AnimationEnvironment`
        /// depending on whether `.dark` or `.light` mode is set and `duration`.
        /// The default `backgroundColor` is set to `nil`, however, we want to adjust it so that the animation is displayed on the appropriate background.
        case animated(animationSource: SplashAnimationSource?, backgroundColor: UIColor? = nil)
    }
    /// Top level Splash screen configuration object
    struct Configuration {
        /// Initializer that loads the default configuration values
        public init() {
            // no code required
        }

        /// A blocking wait handler designed for use during the display of the splash screen.
        ///
        /// This handler performs a wait operation before transitioning away from the splash screen,
        /// effectively controlling the duration for which the splash screen remains visible.
        /// By default, it invokes `didFinishWaiting` on the `Splash.Router` after a specified delay,
        /// allowing for customizable behavior upon the completion of the wait time.
        ///
        /// The delay before calling `didFinishWaiting` is determined as follows:
        /// - If the splash screen type is `.animated` and a specific `duration` is provided through the
        ///   `SplashAnimationSource` associated with the animation, this `duration` is used as the delay.
        /// - If the above condition is not met (including scenarios where the splash screen is not animated
        ///   or no specific duration is provided), a default delay of 2 seconds is applied.
        ///
        /// It is crucial to ensure that `didFinishWaiting` is called to enable the transition away from the splash screen.
        /// This can be customized or overridden as needed to accommodate additional tasks or requirements specific to the splash screen.
        public var waitHandler: (() -> Void)? = {
            guard let configuration = Resolver.optional(Splash.Configuration.self) else { return }
            let delay: Double = {
                if case .animated(let animationSource, _) = configuration.splashScreenType, let duration = animationSource?.duration {
                    return duration
                } else {
                    return 2
                }
            }()
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                configuration.router.didFinishWaiting?()
            }
        }

        /// Splash router.
        public var router = Router()

        /// Background images to cycle from when displaying the Splash screen. Defaults to `nil`.
        public var backgroundImage: UIImage?

        /// Logo image to display on the Splash screen. Defaults to `nil`.
        public var logoImage: UIImage?

        /// Configuration of styles used on the Splash screen
        public var design = Design()

        /// Configuration of strings used on the Splash screen
        public var strings = Strings()
        
        /// The splash screen type represents which version is to displayed. Defaults to `.stationary`.
        public var splashScreenType: SplashScreenType = .stationary
    }
}
