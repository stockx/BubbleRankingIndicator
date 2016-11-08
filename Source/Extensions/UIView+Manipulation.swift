//
//  UIView+Manipulation.swift
//  BubbleRankingIndicator
//
//  Created by Sklar, Josh on 10/10/16.
//  Copyright © 2016 Sklar. All rights reserved.
//

import UIKit

extension UIView {
    /**
     Rounds the corners of 'self' to form a circle, based on the current width.
     */
    func makeCircular() {
        layer.cornerRadius = bounds.width / 2.0;
        clipsToBounds = true
    }
}
