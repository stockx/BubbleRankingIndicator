//
//  CircularLevelRankView.swift
//  CircularLevelRankingIndicator
//
//  Created by Sklar, Josh on 10/5/16.
//  Copyright © 2016 Sklar. All rights reserved.
//

import UIKit

// Libs
import SnapKit

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
    
    /**
     The padding value between the contentView and its superview.
     In other words, the size of the outer ring.
     */
    private let padding: CGFloat = 2.5
    
    init(rank: CircularLevelRank) {
        self.rank = rank
        super.init(frame: CGRectZero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        // TODO: REMOVE THIS LINE
        backgroundColor = UIColor.blueColor()
        
        label.clipsToBounds = true
        label.textAlignment = .Center

        addSubview(contentView)
        contentView.addSubview(label)
        contentView.backgroundColor = UIColor.lightGrayColor()
        
        update()
    }
    
    override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented. Use init(rank:).")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Use init(rank:).")
    }
    
    private func update() {
        label.text = rank.name
        // TODO: Update background image
    }
    
    // MARK: View
    
    override func layoutSubviews() {
        super.layoutSubviews()
        makeCircular()
        contentView.makeCircular()
    }
    
    override func updateConstraints() {
        contentView.snp_remakeConstraints { make in
            make.edges.equalToSuperview().inset(self.padding)
        }
        
        label.snp_remakeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        super.updateConstraints()
    }
}

extension UIView {
    // TODO: Move this somewhere else.
    func makeCircular() {
        layer.cornerRadius = CGRectGetWidth(bounds) / 2.0;
        clipsToBounds = true
    }
}