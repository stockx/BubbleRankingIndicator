//
//  ViewController.swift
//  BubbleRankingIndicator
//
//  Created by Sklar, Josh on 10/5/16.
//  Copyright © 2016 Sklar. All rights reserved.
//

import UIKit

// Libs
import SnapKit

class ViewController: UIViewController {

    var ranking: BubbleRankingIndicatorView!
    
    @IBOutlet weak var numberOfRanksTextField: UITextField!
    @IBOutlet weak var activeRankTextField: UITextField!
    @IBOutlet weak var drawViewButton: UIButton!
    
    @IBOutlet weak var bubbleRankingIndicatorContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var ranks = [Rank]()
        ranks.append(Rank(level: 0, name: "1", backgroundImageName: "https://www.eurweb.com/wp-content/uploads/2011/10/kanye_west2011-paris-fashion-show-headshot-big-ver-upper.jpg"))
        ranks.append(Rank(level: 1, name: "2", backgroundImageName: "https://speakerdata.s3.amazonaws.com/photo/image/873292/KimKardashian300232.jpg"))
        ranks.append(Rank(level: 2, name: "3", backgroundImageName: "https://t4.rbxcdn.com/ec3f660cb0d5b1d080c951169a98d9f4"))
        ranks.append(Rank(level: 3, name: "4", backgroundImageName: "https://www.eurweb.com/wp-content/uploads/2010/02/michael_jordan2010-headshot-blk-brgd-med-wide.jpg"))

        var state = BubbleRankingIndicatorView.State()
        state.ranks = ranks
        state.activeRankLevel = 0
        state.unachievedRankBackgroundColor = UIColor.lightGrayColor()
        state.rankNameFont = UIFont.systemFontOfSize(30)
        state.rankNameColor = UIColor.whiteColor()
        state.rankLevelOnActiveRankIsHidden = false
        
        let ranking = BubbleRankingIndicatorView(state: state)
        
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
        
        var ranks = [Rank]()
        
        for index in 0..<numberOfRanks {
            ranks.append(Rank(level: index, name: String(index), backgroundImageName: "https://speakerdata.s3.amazonaws.com/photo/image/873292/KimKardashian300232.jpg"))
        }
        
        var state = self.ranking.state
        state.activeRankLevel = activeRank
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
