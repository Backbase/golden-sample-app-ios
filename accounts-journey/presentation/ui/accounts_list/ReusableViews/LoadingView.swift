//
//  LoadingView.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 16/11/2023.
//

import Foundation
import UIKit
import BackbaseDesignSystem
import Resolver

final class LoadingView: UIView {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.tintColor = DesignSystem.shared.colors.primary.lighter
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    var configuration: AccountsJourney.Configuration = Resolver.resolve()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func startAnimating() {
        activityIndicator.startAnimating()
    }
    
    func stopAnimating() {
        activityIndicator.stopAnimating()
    }
    
    private func setupView() {
        configureLayout()
        configureDesign()
    }
    
    private func configureLayout() {
        backgroundColor = DesignSystem.shared.colors.surfacePrimary.default
        containerView.backgroundColor = DesignSystem.shared.colors.surfacePrimary.default
    }
    private func configureDesign() {
        addSubview(containerView)
        containerView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor ),
            containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            activityIndicator.topAnchor.constraint(equalTo: containerView.topAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: DesignSystem.shared.sizer.xl),
            activityIndicator.heightAnchor.constraint(equalToConstant: DesignSystem.shared.sizer.xl)
        ])
    }
}
