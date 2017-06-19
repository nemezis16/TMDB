//
//  SearchViewController.swift
//  TMDB
//
//  Created by Roman Osadchuk on 6/18/17.
//  Copyright © 2017 RomanOsadchuk. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet var searchTableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    var moviesDataSource = MoviesDataSource()
    
    var currentGenre: TMDBConstants.Genre!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true
        setupSearchController()
        registerCell()
        searchTableView.dataSource = moviesDataSource
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchController.isActive = true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = searchTableView.indexPathForSelectedRow else {
            print("Error")
            return
        }
        
        let cell = searchTableView.cellForRow(at: indexPath) as! MoviesTableViewCell
        let selectedPoster = cell.movieImageView.image ?? UIImage()
        let selectedMovie = moviesDataSource.moviesList[indexPath.row]
        
        if let detailController = segue.destination as? MoviesDetailViewController {
            detailController.movieModel = selectedMovie
            detailController.poster = selectedPoster
        }
    }
    
//MARK: - Private
    
    fileprivate func setupSearchController() {
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchTableView.tableHeaderView = searchController.searchBar
    }
    
    fileprivate func searchMovie(for query: String) {
        NetworkFacade.searchMovies(for: currentGenre, query: query) { (result) in
            switch result {
            case .Success(let result):
                self.moviesDataSource.moviesList = result
                self.searchTableView.reloadData()
            case .Failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    fileprivate func registerCell() {
        let cellIdentifier = String(describing: MoviesTableViewCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        searchTableView.register(nib, forCellReuseIdentifier: cellIdentifier)
    }
    
}

//MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let segueIdentifier = String(describing: MoviesDetailViewController.self)
        performSegue(withIdentifier: segueIdentifier, sender: self)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}

//MARK: - UISearchResultsUpdating

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        searchMovie(for: searchController.searchBar.text!)
    }
    
}

//MARK: - UISearchControllerDelegate

extension SearchViewController: UISearchControllerDelegate {
    
    func didPresentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.becomeFirstResponder()
    }
    
}

//MARK: - UISearchControllerDelegate

extension SearchViewController: UISearchBarDelegate {

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationController?.popViewController(animated: true)
    }

}

