//
//  CircularLevelRankingIndicatorView.swift
//  CircularLevelRankingIndicator
//
//  Created by Sklar, Josh on 10/5/16.
//  Copyright © 2016 Sklar. All rights reserved.
//

import UIKit

struct CircularLevelRank {
    let name: String
    let backgroundImageName: String?
}

class CircularLevelRankingIndicatorView: UIView {

    let ranks: [CircularLevelRank]
    
    // MARK: Init
    init(ranks: [CircularLevelRank]) {
        self.ranks = ranks
        
        super.init(frame: CGRectZero)
        
        initializeLevelRanks()
        
        backgroundColor = UIColor.greenColor()
    }
    
    override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented. Use init(ranks:).")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Use init(ranks:).")
    }
    
    // MARK: Internal
    
    func initializeLevelRanks() {
        ranks.forEach {
            let rankView = CircularLevelRankView(rank: $0)
            
        }
    }
}
