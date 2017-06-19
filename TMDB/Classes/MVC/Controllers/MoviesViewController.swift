//
//  MoviesViewController.swift
//  TMDB
//
//  Created by Roman Osadchuk on 6/17/17.
//  Copyright © 2017 RomanOsadchuk. All rights reserved.
//

import UIKit
import ObjectMapper

class MoviesViewController: UIViewController {
 
    @IBOutlet var moviesTableView: UITableView!
    
    var currentGenre = TMDBConstants.Genre.Movie
    var currentBlockFilter = TMDBConstants.BlockFilter.Popular
    var moviesDataSource = MoviesDataSource()
    
//MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        fetchData()
        
        moviesTableView.dataSource = moviesDataSource
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let searchController = segue.destination as? SearchViewController {
            searchController.currentGenre = currentGenre
            return
        }
        
        guard let indexPath = moviesTableView.indexPathForSelectedRow else {
            print("Error")
            return
        }
        
        let cell = moviesTableView.cellForRow(at: indexPath) as! MoviesTableViewCell
        let selectedPoster = cell.movieImageView.image ?? UIImage()
        let selectedMovie = moviesDataSource.moviesList[indexPath.row]
        
        if let detailController = segue.destination as? MoviesDetailViewController {
            detailController.movieModel = selectedMovie
            detailController.poster = selectedPoster
        }
    }
   
//MARK: - Action
    
    @IBAction func handleBlockFilterValueChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            currentBlockFilter = .Popular
        case 1:
            currentBlockFilter = .TopRated
        case 2:
            currentBlockFilter = currentGenre == .Movie ? .NowPlaying : .OnTheAir
        default:
            currentBlockFilter = .Popular
        }
        fetchData()
    }
    
    @IBAction func handleGenresChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            currentGenre = .Movie
        case 1:
            currentGenre = .TV
        default:
            currentGenre = .Movie
        }
        if currentBlockFilter == .NowPlaying || currentBlockFilter == .OnTheAir {
            currentBlockFilter = currentGenre == .Movie ? .NowPlaying : .OnTheAir
        }
        fetchData()
    }

//MARK: - Private
    
    fileprivate func fetchData() {
        NetworkFacade.fetchMovies(for: currentGenre, blockFilter: currentBlockFilter) { (result) in
            switch result {
            case .Success(let result):
                self.moviesDataSource.moviesList = result
                self.moviesTableView.reloadData()
            case .Failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    fileprivate func registerCell() {
        let cellIdentifier = String(describing: MoviesTableViewCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        moviesTableView.register(nib, forCellReuseIdentifier: cellIdentifier)
    }
    
}

extension MoviesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let segueIdentifier = String(describing: MoviesDetailViewController.self)
        performSegue(withIdentifier: segueIdentifier, sender: self)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}
