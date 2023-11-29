//
//  LoadingView.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 16/11/2023.
//

import Foundation
import UIKit
import BackbaseDesignSystem
import SnapKit
import Resolver


final class LoadingView: UIView {
    private lazy var containerView = UIView()
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.tintColor = DesignSystem.shared.colors.primary.lighter
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
        
        containerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        containerView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(DesignSystem.shared.sizer.xl)
            make.height.equalTo(DesignSystem.shared.sizer.xl)
        }
    }
}
