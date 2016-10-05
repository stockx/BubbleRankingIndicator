//
//  CircularLevelRankingIndicatorView.swift
//  CircularLevelRankingIndicator
//
//  Created by Sklar, Josh on 10/5/16.
//  Copyright © 2016 Sklar. All rights reserved.
//

import UIKit

// Libs
import SnapKit

struct CircularLevelRank {
    let name: String
    let backgroundImageName: String?
}

class CircularLevelRankingIndicatorView: UIView {

    let ranks: [CircularLevelRank]
    
    private let rankViews: [CircularLevelRankView]
    
    // MARK: Init
    init(ranks: [CircularLevelRank]) {
        self.ranks = ranks
        self.rankViews = self.ranks.map { CircularLevelRankView(rank: $0) }
        
        super.init(frame: CGRectZero)
        
        backgroundColor = UIColor.greenColor()
        
        self.rankViews.forEach {
            self.addSubview($0)
        }
    }
    
    override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented. Use init(ranks:).")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Use init(ranks:).")
    }
    
    // MARK: View
    
    override func updateConstraints() {
        
        let width = bounds.width
        let height = bounds.height
        
        // If the view height is too small to accomodate for the circular
        // level ranks to all be right next to eachother, don't do anything and
        // print a warning message to the console.
        // Currently (v1.0), this does not support when the height is too small
        // thus requiring the ranks to be spaced out.
        let targetedDiameter = width / CGFloat(ranks.count)
        
        guard targetedDiameter <= height else {
            print("CircularLevenRankingIndicatorView: View is too short to support circular level ranks.\nNot drawing any ranks")
            self.rankViews.forEach { $0.snp_removeConstraints() }
            super.updateConstraints()
            return
        }
        
        for (index, rankView) in self.rankViews.enumerate() {
            // If it's the first one, anchor it to the left side.
            if index == 0 {
                rankView.snp_remakeConstraints { make in
                    make.centerY.equalToSuperview()
                    make.left.equalToSuperview()
                    make.height.equalTo(rankView.snp_width)
                }
            }
            
            // If it's somewhere in the middle or the end, anchor the left to to the previous one,
            // and set the height and width equal
            if index > 0 && index <= (self.rankViews.count - 1) {
                rankView.snp_remakeConstraints { make in
                    make.centerY.equalToSuperview()
                    make.left.equalTo(self.rankViews[index - 1].snp_right)
                    make.height.equalTo(self.rankViews[index - 1].snp_height)
                    make.width.equalTo(self.rankViews[index - 1].snp_width)
                }
            }
            
            // If it's the last one, add (not snp_make, not snp_remake since we don't
            // want to blow away the ones we just created) an anchor to the right side
            if index == self.rankViews.count - 1 {
                rankView.snp_makeConstraints { make in
                    make.centerY.equalToSuperview()
                    make.right.equalToSuperview()
                }
            }
            
        }
        
        super.updateConstraints()
    }
}
