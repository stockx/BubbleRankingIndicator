//
//  CircularLevelRankView.swift
//  CircularLevelRankingIndicator
//
//  Created by Sklar, Josh on 10/5/16.
//  Copyright © 2016 Sklar. All rights reserved.
//

import UIKit

class CircularLevelRankView: UIView {
    
    var rank: CircularLevelRank {
        didSet {
            update()
        }
    }
    
    /**
     The label used to display the level name.
     */
    private let label = UILabel()
    
    /**
     The inner subview. This view is slightly smaller than `self`, and is what is used
     to display the content of othe level (name and background image).
     */
    private let contentView = UIView()
    
    init(rank: CircularLevelRank) {
        self.rank = rank
        super.init(frame: CGRectZero)
        
        // TODO: REMOVE THIS LINE
        backgroundColor = UIColor.blueColor()
        
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.clipsToBounds = true
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        makeCircular()
        
        addSubview(contentView)
        contentView.addSubview(label)
        
        let views = ["label": label, "contentView": contentView]
        let metrics = ["padding": 10]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-padding-[contentView]-padding-|",
            options: [],
            metrics: metrics,
            views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-padding-[contentView]-padding-|",
            options: [],
            metrics: metrics,
            views: views))
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[label]|",
            options: [],
            metrics: metrics,
            views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[label]|",
            options: [],
            metrics: metrics,
            views: views))
    }
    
    override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented. Use init(rank:).")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Use init(rank:).")
    }
    
    // TODO: Move this somewhere else.
    func makeCircular() {
        layer.cornerRadius = CGRectGetWidth(bounds) / 2.0;
        clipsToBounds = true
    }
    
    private func update() {
        // Update the level name and background image
    }
}
