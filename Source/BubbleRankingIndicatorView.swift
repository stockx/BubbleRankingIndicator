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
        /// Whether or not the rank level number is hidden on the active bubble rank.
        /// Defaults to true.
        public var rankNameOnActiveRankIsHidden: Bool
        
        init() {
            ranks = []
            activeRankLevel = 0
            unachievedRankBackgroundColor = .lightGray
            rankNameFont = .systemFont(ofSize: 16)
            rankNameColor = .white
            rankNameOnActiveRankIsHidden = true
        }
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
    
    fileprivate var rankViews = [BubbleRankView]()
    
    // MARK: Init
    
    public init(state: State) {
        self.state = state
        
        super.init(frame: CGRect.zero)
        
        commonInit()
    }
    
    override public init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented. Use init(state:).")
    }
    
    required public init?(coder aDecoder: NSCoder) {
        let defaultState = State()
        self.state = defaultState
        
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    fileprivate func commonInit() {
        self.rankViews.forEach {
            self.addSubview($0)
        }
        
        // Use a default state for the oldValue
        let defaultState = State()
        update(defaultState)
    }
    
    // MARK: State
    
    func update(_ oldState: State) {
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
        for (index, rankView) in self.rankViews.enumerated() {
            let rankIsActive = self.state.ranks[index].level == self.state.activeRankLevel
            
            var state = BubbleRankView.State(rank: self.state.ranks[index],
                                             isActive: rankIsActive,
                                             hasAchievedRank: self.state.ranks[index].level <= self.state.activeRankLevel,
                                             outerRingColor: .white,
                                             backgroundColor: self.state.unachievedRankBackgroundColor,
                                             rankNameFont: self.state.rankNameFont,
                                             rankNameColor: self.state.rankNameColor,
                                             rankLevelLabelIsHidden: false)
            state.rankLevelLabelIsHidden = rankIsActive && self.state.rankNameOnActiveRankIsHidden
            
            rankView.state = state
        }
        
        self.setNeedsUpdateConstraints()
    }
    
    // MARK: View
    
    override public func updateConstraints() {
        
        guard self.state.ranks.count > 0 else {
            super.updateConstraints()
            return
        }
        
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
            self.rankViews.forEach { $0.snp.removeConstraints() }
            super.updateConstraints()
            return
        }
        
        var inactiveRankViews = [BubbleRankView]()
        var activeRankView: BubbleRankView? = nil
        
        var hasShownActiveRankView = false
        
        for (index, rankView) in self.rankViews.enumerated() {
            // If it's the first one, anchor it to the left side.
            if index == 0 {
                rankView.snp.remakeConstraints { make in
                    make.centerY.equalToSuperview()
                    make.left.equalToSuperview()
                    make.height.equalTo(rankView.snp.width)
                }
            }
            
            // If it's somewhere in the middle or the end, anchor the left to to the previous one,
            // and set the height and width equal
            if index > 0 && index <= (self.rankViews.count - 1) {
                rankView.snp.remakeConstraints { make in
                    make.centerY.equalToSuperview()
                    make.left.equalTo(self.rankViews[index - 1].snp.right).offset(-20)
                    make.height.equalTo(rankView.snp.width)
                }
            }
            
            // If it's the last one, add (snp.make, not snp.remake since we don't
            // want to blow away the ones we just created) an anchor to the right side
            if index == self.rankViews.count - 1 {
                rankView.snp.makeConstraints { make in
                    make.centerY.equalToSuperview()
                    make.right.equalToSuperview()
                }
            }

            if rankView.state?.isActive == true {
                bringSubview(toFront: rankView)
                hasShownActiveRankView = true
                activeRankView = rankView
            }
            else {
                if !hasShownActiveRankView {
                    bringSubview(toFront: rankView)
                }
                else {
                    sendSubview(toBack: rankView)
                }
                inactiveRankViews.append(rankView)
            }
        }
        
        // Make all width's of the inactive rankViews equal.
        for (index, rankView) in inactiveRankViews.enumerated() {
            if index > 0 {
                rankView.snp.makeConstraints { make in
                    make.width.equalTo(inactiveRankViews[index - 1].snp.width)
                }
            }
        }
        
        // Make the width of the active rankView larger than the inactive ones.
        if let activeRankView = activeRankView,
            let firstInactiveRankView = inactiveRankViews.first {
            activeRankView.snp.makeConstraints { make in
                make.width.equalTo(firstInactiveRankView.snp.width).multipliedBy(self.activeRankSizeMultiplier)
            }
        }
        
        super.updateConstraints()
    }
}
