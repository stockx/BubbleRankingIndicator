//
//  BubbleRankingIndicatorView.swift
//  BubbleRankingIndicator
//
//  Created by Sklar, Josh on 10/5/16.
//  Copyright © 2016 Sklar. All rights reserved.
//

import UIKit

// Libs
import SnapKit

public struct Rank {
    public let level: Int
    public let name: String
    public let backgroundImageName: String?
    
    public init(level: Int, name: String, backgroundImageName: String?) {
        self.level = level
        self.name = name
        self.backgroundImageName = backgroundImageName
    }
}

public class BubbleRankingIndicatorView: UIView {
    
    public struct State {
        public var ranks: [Rank]
        public var activeRankLevel: Int
        public var unachievedRankBackgroundColor: UIColor
        public var rankNameFont: UIFont
        public var rankNameColor: UIColor
    }
    
    public var state: State {
        didSet {
            update(oldValue)
        }
    }
    
    /**
     Represents how much larger the active BubbleRankView
     will be than the inactive ones.
     */
    public let activeRankSizeMultiplier: CGFloat = 1.3
    
    private var rankViews = [BubbleRankView]()
    
    // MARK: Init
    
    public init(state: State) {
        self.state = state
        
        super.init(frame: CGRectZero)
        
        self.rankViews.forEach {
            self.addSubview($0)
        }
        
        // Use a default state for the oldValue
        let defaultState = State(ranks: [],
                                 activeRankLevel: 0,
                                 unachievedRankBackgroundColor: UIColor.whiteColor(),
                                 rankNameFont: UIFont.systemFontOfSize(UIFont.systemFontSize()),
                                 rankNameColor: UIColor.whiteColor())
        update(defaultState)
    }
    
    override public init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented. Use init(state:).")
    }
    
    required public init?(coder aDecoder: NSCoder) {
        let defaultState = State(ranks: [], activeRankLevel: 0, unachievedRankBackgroundColor: UIColor.lightGrayColor(), rankNameFont: UIFont.systemFontOfSize(16), rankNameColor: UIColor.whiteColor())
        self.state = defaultState
        
        super.init(coder: aDecoder)
        
        self.rankViews.forEach {
            self.addSubview($0)
        }
        
        // Use a default state for the oldValue
        update(defaultState)
    }
    
    // MARK: State
    
    func update(oldState: State) {
        // If the number of ranks has changed, need to remove the old ones and
        // add the new ones.
        if oldState.ranks.count != self.state.ranks.count {
            self.rankViews.forEach {
                $0.removeFromSuperview()
            }
            self.rankViews = self.state.ranks.map { _ in
                return BubbleRankView(frame: CGRect.zero)
            }
            
            self.rankViews.forEach {
                self.addSubview($0)
            }
            
        }
        
        // Update all the rankViews state's.
        for (index, rankView) in self.rankViews.enumerate() {
            rankView.state =  BubbleRankView.State(rank: self.state.ranks[index],
                                                   isActive: self.state.ranks[index].level == self.state.activeRankLevel,
                                                   hasAchievedRank: self.state.ranks[index].level <= self.state.activeRankLevel,
                                                   outerRingColor: UIColor.whiteColor(),
                                                   backgroundColor: self.state.unachievedRankBackgroundColor,
                                                   rankNameFont: self.state.rankNameFont,
                                                   rankNameColor: self.state.rankNameColor)
        }
        
        self.setNeedsUpdateConstraints()
    }
    
    // MARK: View
    
    override public func updateConstraints() {
        
        let width = bounds.width
        let height = bounds.height
        
        // If the view height is too small to accomodate for the bubbles to all
        // be right next to eachother, don't do anything and
        // print a warning message to the console.
        // Currently (v1.0), this does not support when the height is too small
        // thus requiring the ranks to be spaced out.
        let targetedDiameter = width / CGFloat(self.state.ranks.count)
        
        guard (targetedDiameter * self.activeRankSizeMultiplier) <= height else {
            print("BubbleRankingIndicator: BubbleRankingIndicatorView is too short to support bubbles given the number of ranks.\nNot drawing any ranks.")
            self.rankViews.forEach { $0.snp_removeConstraints() }
            super.updateConstraints()
            return
        }
        
        var inactiveRankViews = [BubbleRankView]()
        var activeRankView: BubbleRankView? = nil
        
        var hasShownActiveRankView = false
        
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
                    make.left.equalTo(self.rankViews[index - 1].snp_right).offset(-20)
                    make.height.equalTo(rankView.snp_width)
                }
            }
            
            // If it's the last one, add (snp_make, not snp_remake since we don't
            // want to blow away the ones we just created) an anchor to the right side
            if index == self.rankViews.count - 1 {
                rankView.snp_makeConstraints { make in
                    make.centerY.equalToSuperview()
                    make.right.equalToSuperview()
                }
            }

            if rankView.state?.isActive == true {
                bringSubviewToFront(rankView)
                hasShownActiveRankView = true
                activeRankView = rankView
            }
            else {
                if !hasShownActiveRankView {
                    bringSubviewToFront(rankView)
                }
                else {
                    sendSubviewToBack(rankView)
                }
                inactiveRankViews.append(rankView)
            }
        }
        
        // Make all width's of the inactive rankViews equal.
        for (index, rankView) in inactiveRankViews.enumerate() {
            if index > 0 {
                rankView.snp_makeConstraints { make in
                    make.width.equalTo(inactiveRankViews[index - 1].snp_width)
                }
            }
        }
        
        // Make the width of the active rankView larger than the inactive ones.
        if let activeRankView = activeRankView,
            let firstInactiveRankView = inactiveRankViews.first {
            activeRankView.snp_makeConstraints { make in
                make.width.equalTo(firstInactiveRankView.snp_width).multipliedBy(self.activeRankSizeMultiplier)
            }
        }
        
        super.updateConstraints()
    }
}
