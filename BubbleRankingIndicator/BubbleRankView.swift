//
//  BubbleRankView.swift
//  BubbleRankingIndicator
//
//  Created by Sklar, Josh on 10/5/16.
//  Copyright © 2016 Sklar. All rights reserved.
//

import UIKit

// Libs
import SnapKit
import Haneke

class BubbleRankView: UIView {
    
    struct State {
        var rank: CircularLevelRank
        var isActive: Bool
        var hasAchievedRank: Bool
        var outerRingColor: UIColor?
        var backgroundColor: UIColor
    }
    
    var state: State? {
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
     The imageview to display the background image of the rank.
     */
    private let imageView = UIImageView()
    
    /**
     The padding value between the contentView and its superview.
     In other words, the size of the outer ring.
     */
    private let padding: CGFloat = 2.5
    
    convenience init(state: State) {
        self.init(frame: CGRectZero)
        self.state = state
        update()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        // TODO: REMOVE THIS LINE
        backgroundColor = UIColor.blueColor()
        
        imageView.clipsToBounds = true
        imageView.contentMode = .ScaleAspectFit
        contentView.addSubview(imageView)
        
        label.clipsToBounds = true
        label.textAlignment = .Center
        contentView.addSubview(label)
        
        
        addSubview(contentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Use init(state:).")
    }
    
    private func update() {
        guard let state = state else {
            return
        }
        
        label.text = state.rank.name
        self.backgroundColor = state.outerRingColor
        self.contentView.backgroundColor = state.backgroundColor
        if let imageURLString = state.rank.backgroundImageName,
            imageURL = NSURL(string: imageURLString) {
            self.imageView.hnk_setImageFromURL(imageURL,
                                               placeholder: nil,
                                               format: Format<UIImage>(name: "RankImages"),
                                               failure: { (error) in
                                                print("Failed fetching rank image from URL \(imageURL). Error: \(error)")
                }, success: { (image) in
                    self.imageView.image = image
            })
        }
        
        imageView.hidden = !state.hasAchievedRank
        
        if state.hasAchievedRank && !state.isActive {
            label.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.25)
        }
        else {
            label.backgroundColor = UIColor.clearColor()
        }
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
        
        imageView.snp_remakeConstraints { (make) in
            make.edges.equalToSuperview()
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