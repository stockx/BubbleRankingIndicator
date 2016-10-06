//
//  ViewController.swift
//  CircularLevelRankingIndicator
//
//  Created by Sklar, Josh on 10/5/16.
//  Copyright © 2016 Sklar. All rights reserved.
//

import UIKit

// Libs
import SnapKit

class ViewController: UIViewController {

    var ranking: CircularLevelRankingIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var ranks = [CircularLevelRank]()
        ranks.append(CircularLevelRank(name: "1", backgroundImageName: nil, isActive: false))
        ranks.append(CircularLevelRank(name: "2", backgroundImageName: nil, isActive: true))
        ranks.append(CircularLevelRank(name: "3", backgroundImageName: nil, isActive: false))
        ranks.append(CircularLevelRank(name: "4", backgroundImageName: nil, isActive: false))
        ranks.append(CircularLevelRank(name: "5", backgroundImageName: nil, isActive: false))
        let ranking = CircularLevelRankingIndicatorView(ranks: ranks)
        
        view.addSubview(ranking)
        
        ranking.snp_remakeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(150)
        }
        
        self.ranking = ranking
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        ranking?.setNeedsUpdateConstraints()
    }
}

