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
        var rank: Rank
        var isActive: Bool
        var hasAchievedRank: Bool
        var outerRingColor: UIColor?
        var backgroundColor: UIColor
        var rankNameFont: UIFont
        var rankNameColor: UIColor
        /// Whether or not the rank level label is hidden.
        /// Defaults to false.
        var rankLevelLabelIsHidden: Bool
    }
    
    var state: State? {
        didSet {
            update()
        }
    }
    
    /**
     The label used to display the level name.
     */
    fileprivate let label = UILabel()
    
    /**
     The inner subview. This view is slightly smaller than `self`, and is what is used
     to display the content of othe level (name and background image).
     */
    fileprivate let contentView = UIView()
    
    /**
     The imageview to display the background image of the rank.
     */
    fileprivate let imageView = UIImageView()
    
    /**
     The padding value between the contentView and its superview.
     In other words, the size of the outer ring.
     */
    fileprivate let padding: CGFloat = 2.5
    
    convenience init(state: State) {
        self.init(frame: CGRect.zero)
        self.state = state
        update()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false

        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        contentView.addSubview(imageView)
        
        label.clipsToBounds = true
        label.textAlignment = .center
        contentView.addSubview(label)
        
        
        addSubview(contentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Use init(state:).")
    }
    
    fileprivate func update() {
        guard let state = state else {
            return
        }
        
        label.text = state.rank.name
        self.backgroundColor = state.outerRingColor
        self.contentView.backgroundColor = state.backgroundColor
        if let imageURLString = state.rank.backgroundImageName,
            let imageURL = URL(string: imageURLString) {
            self.imageView.hnk_setImageFromURL(imageURL,
                                               placeholder: nil,
                                               format: Format<UIImage>(name: "RankImages"),
                                               failure: { (error) in
                                                print("Failed fetching rank image from URL \(imageURL). Error: \(String(describing: error))")
                }, success: { (image) in
                    self.imageView.image = image
            })
        }
        
        imageView.isHidden = !state.hasAchievedRank
        
        if state.hasAchievedRank && !state.isActive {
            label.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        }
        else {
            label.backgroundColor = .clear
        }
        
        label.isHidden = state.rankLevelLabelIsHidden
        
        label.font = state.rankNameFont
        label.textColor = state.rankNameColor
    }
    
    // MARK: View
    
    override func layoutSubviews() {
        super.layoutSubviews()
        makeCircular()
        contentView.makeCircular()
    }
    
    override func updateConstraints() {
        contentView.snp.remakeConstraints { make in
            make.edges.equalToSuperview().inset(self.padding)
        }
        
        imageView.snp.remakeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        label.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        super.updateConstraints()
    }
}
