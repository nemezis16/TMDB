//
//  URLProvider.swift
//  TMDB
//
//  Created by Roman Osadchuk on 6/17/17.
//  Copyright © 2017 RomanOsadchuk. All rights reserved.
//

import Foundation

class URLProvider {
    
    class func getMoviesURL(for genre:TMDBConstants.Genre, blockFilter: TMDBConstants.BlockFilter) -> URL? {
        let urlComposer = URLComposer()
        urlComposer.scheme = TMDBConstants.SchemeHTTPS
        urlComposer.host = TMDBConstants.API.Host
        urlComposer.pathComponents = [TMDBConstants.API.Version, genre.rawValue ,blockFilter.rawValue]
        urlComposer.queryItems = [TMDBConstants.API.KeyName : TMDBConstants.API.KeyValue]
        let url = urlComposer.getComposed()
        
        return url
    }
    
    class func getSearchURL(for genre:TMDBConstants.Genre, query: String) -> URL? {
        let urlComposer = URLComposer()
        urlComposer.scheme = TMDBConstants.SchemeHTTPS
        urlComposer.host = TMDBConstants.API.Host
        urlComposer.pathComponents = [TMDBConstants.API.Version, TMDBConstants.Search.Path, genre.rawValue]
        urlComposer.queryItems = [TMDBConstants.API.KeyName : TMDBConstants.API.KeyValue, TMDBConstants.Search.Query : query]
        let url = urlComposer.getComposed()
        
        return url
    }
    
    class func getImageURL(for filePath: String) -> URL? {
        let urlComposer = URLComposer()
        urlComposer.scheme = TMDBConstants.SchemeHTTPS
        urlComposer.host = TMDBConstants.Image.Host
        urlComposer.pathComponents = [TMDBConstants.Image.Path,TMDBConstants.Image.DefaultSize, filePath]
        let url = urlComposer.getComposed()
        
        return url
    }
    
}
