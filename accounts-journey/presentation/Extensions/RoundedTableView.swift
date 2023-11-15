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
    private var topConstraint: NSLayoutConstraint?
    private var bottomConstraint: NSLayoutConstraint?
    
    let placeHolderHeader = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal override init(frame: CGRect = .zero, style: UITableView.Style = .plain) {
        super.init(frame: frame, style: style)
        // Default views (Needed for the background view)
        tableHeaderView = placeHolderHeader
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
        
        guard let superView = superview, let footer = tableFooterView, let header = tableHeaderView else { return }
        
        superView.insertSubview(backViewCard, belowSubview: self)
        
        backViewCard.translatesAutoresizingMaskIntoConstraints = false
        backViewCard.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backViewCard.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        topConstraint = backViewCard.topAnchor.constraint(equalTo: header.topAnchor)
        topConstraint?.isActive = true
        
        bottomConstraint = backViewCard.bottomAnchor.constraint(equalTo: footer.topAnchor)
        bottomConstraint?.isActive = true
        
        self.tableViewBackView = backViewCard
    }
}
