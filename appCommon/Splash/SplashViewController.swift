//
//  SplashViewController.swift
//  AppCommon
//
//  Created by George Nyakundi on 04/02/2025.
//

import UIKit
import Resolver
import BackbaseAnimation
import BackbaseDesignSystem

final internal class SplashViewController: UIViewController {
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        UIInterfaceOrientationMask.portrait
    }

    // MARK: - View lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch config.splashScreenType {
        case .stationary:
            loadViewForStaticScreen()
            titleLabel.text = config.strings.title?()
            subtitleLabel.text = config.strings.subtitle?()
            backgroundImageView.image = config.backgroundImage
            logoImageView.image = config.logoImage
            
            config.design.logo(logoImageView)
            config.design.title(titleLabel)
            config.design.subtitle(subtitleLabel)
            config.design.indicator(activityIndicator)
        case .animated(_, let backgroundColor):
            loadViewForDynamicScreen()
            view.backgroundColor = backgroundColor
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if case .animated = config.splashScreenType {
            animationView.start()
        }
        
        config.waitHandler?()
    }
    
    // MARK: - Private
    
    @LazyInjected
    private var config: Splash.Configuration
    
    // MARK: Static splash screen
    private func loadViewForStaticScreen() {
        let backgroundColor = UIColor(
            light: Theme.colors.background.brand,
            dark: Theme.colors.background.page
        )
        view.backgroundColor = backgroundColor
        [backgroundImageView, titleLabel, subtitleLabel, logoImageView, activityIndicator].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        })
        
        let safeArea = view.safeAreaLayoutGuide
        
        // Apply constraints
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8*13)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8*2),
            titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8*2),
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 8*3)
        ])
        
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8*7)
        ])
    }
    
    private let backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let logoImageView: UIImageView = {
        let view = UIImageView()
        view.accessibilityIdentifier = "splash.logo"
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.accessibilityIdentifier = "splash.title"
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.accessibilityIdentifier = "splash.subtitle"
        return label
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.startAnimating()
        return view
    }()
    
    // MARK: Dynamic splash screen
    private func loadViewForDynamicScreen() {
        view.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            animationView.topAnchor.constraint(equalTo: view.topAnchor),
            animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @LazyInjected
    private var animationViewFactory: AnimationViewFactory.Type
    
    private lazy var animationView: AnimationView = {
        let view = animationViewFactory.view()
        if case let .animated(animationSource, _) = config.splashScreenType, let source = animationSource?.source {
            try? view.load(from: source)
        }
        view.accessibilityIdentifier = "splash.animationView"
        return view
    }()
}
