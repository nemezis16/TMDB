//
//  MoviesDetailViewController.swift
//  TMDB
//
//  Created by Roman Osadchuk on 6/18/17.
//  Copyright © 2017 RomanOsadchuk. All rights reserved.
//

import UIKit
import Cosmos

class MoviesDetailViewController: UIViewController {
    
    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var movieDescription: UITextView!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    
    @IBOutlet var cosmosView: CosmosView!
    
    var rating: Double = 0.0 {
        didSet {
            ratingLabel.text = String(format: "%.1f", rating / 2.0)
            cosmosView.rating = rating / 2.0
        }
    }
    var movieModel: MovieModel!
    var poster: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = movieModel.name ?? movieModel.title
        movieTitle.text = title
        movieDescription.text = movieModel.overview
        movieImageView.image = poster ?? UIImage()
        rating = Double(movieModel.vote_average ?? 0)
    }
    
}
