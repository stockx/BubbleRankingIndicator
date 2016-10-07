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

    var ranking: CircularLevelRankingIndicatorView!
    
    @IBOutlet weak var numberOfRanksTextField: UITextField!
    @IBOutlet weak var activeRankTextField: UITextField!
    @IBOutlet weak var drawViewButton: UIButton!
    
    @IBOutlet weak var bubbleRankingIndicatorContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var ranks = [CircularLevelRank]()
        ranks.append(CircularLevelRank(name: "1", backgroundImageName: nil, isActive: false))
        ranks.append(CircularLevelRank(name: "2", backgroundImageName: nil, isActive: true))
        ranks.append(CircularLevelRank(name: "3", backgroundImageName: nil, isActive: false))
        ranks.append(CircularLevelRank(name: "4", backgroundImageName: nil, isActive: false))
        ranks.append(CircularLevelRank(name: "5", backgroundImageName: nil, isActive: false))
        let state = CircularLevelRankingIndicatorView.State(ranks: ranks, unachievedRankBackgroundColor: UIColor.lightGrayColor())
        
        let ranking = CircularLevelRankingIndicatorView(state: state)
        
        bubbleRankingIndicatorContainerView.addSubview(ranking)
        
        ranking.snp_remakeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.ranking = ranking
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        ranking!.setNeedsUpdateConstraints()
    }
    
    @IBAction func drawBubbleRankingIndicatorView(sender: UIButton) {
        guard let numberOfRanks = Int(numberOfRanksTextField.text ?? ""),
            let activeRank = Int(activeRankTextField.text ?? "") where activeRank < numberOfRanks else {
                return
        }
        
        var ranks = [CircularLevelRank]()
        
        for index in 0..<numberOfRanks {
            ranks.append(CircularLevelRank(name: String(index), backgroundImageName: nil, isActive: index == activeRank))
        }
        
        var state = self.ranking.state
        state.ranks = ranks
        self.ranking.state = state
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.drawBubbleRankingIndicatorView(self.drawViewButton)
        return true
    }
}
