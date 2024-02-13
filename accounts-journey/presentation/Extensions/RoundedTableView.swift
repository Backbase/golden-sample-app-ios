//
//  RoundedTableView.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 13/11/2023.
//

import Foundation
import UIKit
import BackbaseDesignSystem

class RoundedTableView: UITableView {
    private var tableViewBackView: Card?
    private var tableContentObserver: NSKeyValueObservation?

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect = .zero, style: UITableView.Style = .plain) {
        super.init(frame: frame, style: style)
        
        clipsToBounds = true
        separatorStyle = .none
        backgroundColor = .clear
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: DesignSystem.shared.spacer.lg, right: 0)
        showsVerticalScrollIndicator = false
        alwaysBounceVertical = false
        // Default views (Needed for the background view)
        tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
    }
    
    override var isHidden: Bool {
        willSet {
            if newValue {
                tableViewBackView?.removeFromSuperview()
            } else {
                adjustTableViewBackView()
            }
        }
    }
    
    override var tableFooterView: UIView? {
        didSet {
            adjustTableViewBackView()
        }
    }
    
    override var tableHeaderView: UIView? {
        didSet {
            adjustTableViewBackView()
        }
    }
    
    private func adjustTableViewBackView() {
        
        if tableViewBackView?.superview != nil {
            tableViewBackView?.removeFromSuperview()
        }
        
        let backViewCard = Card()
        DesignSystem.shared.styles.cardView(backViewCard)
        backViewCard.backgroundColor = DesignSystem.shared.colors.surfacePrimary.default
        
        guard let superView = superview, let footer = tableFooterView, let tableHeaderView else { return }
        
        superView.insertSubview(backViewCard, belowSubview: self)
        
        backViewCard.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(footer.snp.top)
        }

        self.tableViewBackView = backViewCard
    }
}
