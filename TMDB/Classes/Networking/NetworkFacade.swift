//
//  NetworkFacade.swift
//  TMDB
//
//  Created by Roman Osadchuk on 6/18/17.
//  Copyright © 2017 RomanOsadchuk. All rights reserved.
//

import UIKit
import ObjectMapper

class NetworkFacade {
    
//MARK: - Typealiases
    typealias GetMoviesResponseHandler = (NetworkResult<Array<MovieModel>>)->Swift.Void
    typealias GetImageResponseHandler = (NetworkResult<UIImage>)->Swift.Void
    
//MARK: - Public
    
    class func fetchMovies(for genre: TMDBConstants.Genre, blockFilter: TMDBConstants.BlockFilter, responseHandler: @escaping GetMoviesResponseHandler) {
                
        guard let url = URLProvider.getMoviesURL(for: genre, blockFilter: blockFilter) else {
            print("Error providing URL")
            return
        }
        
        let request = URLRequest(url: url)
        NetworkManager.shared.get(request: request) { (response) in
            switch response {
            case .Success(let result):
                if let json = result as? [String : Any], let jsonArray = json["results"] as? [[String : Any]] {
                    let moviesList = Mapper<MovieModel>().mapArray(JSONArray: jsonArray) ?? [MovieModel]()
                    responseHandler(.Success(moviesList))
                }
            case .Failure(let error):
//                print(URLCache.shared.cachedResponse(for: request)?.data.description ?? "assa")
                responseHandler(.Failure(error))
            }
        }
    }
    
    class func fetchImage(for filePath: String, responseHandler: @escaping GetImageResponseHandler) {
        
        guard let url = URLProvider.getImageURL(for: filePath) else {
            print("Error providing URL")
            return
        }
        
        let request = URLRequest(url: url)
        NetworkManager.shared.get(request: request) { (response) in
            switch response {
            case .Success(let data):
                if let image = UIImage(data: data as! Data) {
                    responseHandler(.Success(image))
                }
            case .Failure(let error):
                responseHandler(.Failure(error))
            }
        }
    }

    class func searchMovies(for genre: TMDBConstants.Genre, query: String, responseHandler: @escaping GetMoviesResponseHandler) {
        
        guard let url = URLProvider.getSearchURL(for: genre, query: query) else {
            print("Error providing URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.cachePolicy = .reloadIgnoringCacheData
        NetworkManager.shared.get(request: request) { (response) in
            switch response {
            case .Success(let result):
                if let json = result as? [String : Any], let jsonArray = json["results"] as? [[String : Any]] {
                    let moviesList = Mapper<MovieModel>().mapArray(JSONArray: jsonArray) ?? [MovieModel]()
                    responseHandler(.Success(moviesList))
                }
            case .Failure(let error):
                responseHandler(.Failure(error))
            }
        }
    }

    
}
