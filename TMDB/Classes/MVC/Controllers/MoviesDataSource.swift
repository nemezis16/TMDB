//
//  MoviesDataSource.swift
//  TMDB
//
//  Created by Roman Osadchuk on 6/18/17.
//  Copyright © 2017 RomanOsadchuk. All rights reserved.
//

import UIKit

class MoviesDataSource:NSObject, UITableViewDataSource {
    
    var moviesList = [MovieModel]()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = String(describing: MoviesTableViewCell.self)
        let movieModel = moviesList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MoviesTableViewCell
        cell.movieTitle.text = movieModel.title ?? movieModel.name
        cell.rating = Double(movieModel.vote_average ?? 0)
        
        if let posterPath = movieModel.poster_path {
            NetworkFacade.fetchImage(for: posterPath) { (result) in
                switch result {
                case .Success(let image):
                    cell.movieImageView.image = image
                case .Failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
       
        return cell
    }

    
}
