//
//  UIView+Helpers.swift
//  TMDB
//
//  Created by Roman Osadchuk on 6/18/17.
//  Copyright © 2017 RomanOsadchuk. All rights reserved.
//

import UIKit

extension UIView {

    func setShadowGradient() {
        let gradient = CAGradientLayer()
        let black3 = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.9).cgColor
        let black2 = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor
        let black1 = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        
        gradient.frame = self.layer.frame
        gradient.colors = [black1, black2, black3]
        self.layer.insertSublayer(gradient, at: 0)
    }
    
}

