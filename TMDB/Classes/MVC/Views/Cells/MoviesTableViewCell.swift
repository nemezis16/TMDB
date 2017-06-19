//
//  MoviesTableViewCell.swift
//  TMDB
//
//  Created by Roman Osadchuk on 6/18/17.
//  Copyright © 2017 RomanOsadchuk. All rights reserved.
//

import UIKit
import Cosmos

class MoviesTableViewCell: UITableViewCell {

//MARK: - Variables
    
    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var ratingLabel: UILabel!

    @IBOutlet var shadowGradientView: UIView!
    
    @IBOutlet var cosmosView: CosmosView!
    
    var rating: Double = 0.0 {
        didSet {
            ratingLabel.text = String(format: "%.1f", rating / 2.0)
            cosmosView.rating = rating / 2.0
        }
    }
    
//MARK: - LifeCycle
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        self.layoutIfNeeded()
        shadowGradientView.setShadowGradient()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        movieImageView.image = UIImage()
        movieTitle.text = ""
        rating = 0.0
    }

}
